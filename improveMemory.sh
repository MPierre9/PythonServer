#!/bin/bash
function SETUP() {
    echo "SETUP - Complete"
}

# catch STDOUT STDERR cmd args..
# https://stackoverflow.com/a/41069638/1275256
catch()
{
eval "$({
__2="$(
  { __1="$("${@:3}")"; } 2>&1;
  ret=$?;
  printf '%q=%q\n' "$1" "$__1" >&2;
  exit $ret
  )"
ret="$?";
printf '%s=%q\n' "$2" "$__2" >&2;
printf '( exit %q )' "$ret" >&2;
} 2>&1 )";
}

function TEST() {

    function set_vm_dirty_background_ratio() {
        echo "Running vm.dirty_background_ratio..."
        command=$(sysctl -ap 2>/dev/null | grep vm.dirty_background_ratio) # scans all sysctl settings looking for 'vm.dirty_background_ratio'
        pat="^vm\.dirty_background_ratio = ([0-9]+)$"
        if [[ $command =~ $pat ]] && (( BASH_REMATCH[1] < 20 )); then
            echo "FAIL - Bad vm.dirty_background_ratio = ${BASH_REMATCH[1]}. Fixing."
            # Temporarily set net to 8192
            echo 20 > /proc/sys/vm/dirty_background_ratio

            # Scan and remove all, if any, instances of net.core/somaxconn
            sed -i -e '/^\.*vm.dirty_background_ratio*$/d' /etc/sysctl.d/*
            sed -i -e '/^\.*vm.dirty_background_ratio*$/d' /usr/lib/sysctl.d/*

            # Create config file with setting
            touch /etc/sysctl.d/vm_dirty_background_ratio.conf
            echo 'vm.dirty_background_ratio = 20' > /etc/sysctl.d/vm_dirty_background_ratio.conf
        else
            echo "OK - vm.dirty_background_ratio = ${BASH_REMATCH[1]}"
        fi
    }

    function set_vm_dirty_ratio() {
        echo "Running vm.dirty_ratio..."
        command=$(sysctl -ap 2>/dev/null | grep vm.dirty_ratio) # scans all sysctl settings looking for 'vm.dirty_ratio'
        pat="^vm\.dirty_ratio = ([0-9]+)$"
        if [[ $command =~ $pat ]] && (( BASH_REMATCH[1] < 50 )); then
            echo "FAIL - Bad vm.dirty_ratio = ${BASH_REMATCH[1]}. Fixing."
            # Temporarily set net to 8192
            echo 50 > /proc/sys/vm/dirty_ratio

            # Scan and remove all, if any, instances of net.core/somaxconn
            sed -i -e '/^\.*vm.dirty_ratio*$/d' /etc/sysctl.d/*
            sed -i -e '/^\.*vm.dirty_ratio*$/d' /usr/lib/sysctl.d/*

            # Create config file with setting
            touch /etc/sysctl.d/vm_dirty_ratio.conf
            echo 'vm.dirty_ratio = 50' > /etc/sysctl.d/vm_dirty_ratio.conf
        else
            echo "OK - vm.dirty_ratio = ${BASH_REMATCH[1]}"
        fi
    }

    set_vm_dirty_background_ratio
    set_vm_dirty_ratio
}

function TEARDOWN() {
    echo "TEARDOWN - Complete"
}

SETUP
TEST
TEARDOWN
