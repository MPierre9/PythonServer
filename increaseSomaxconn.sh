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
    command=$(sysctl -ap 2>/dev/null | grep net.core.somaxconn) # scans all sysctl settings looking for 'net.core.somaxconn'
    pat="^net\.core\.somaxconn = ([0-9]+)$"
    if [[ $command =~ $pat ]] && (( BASH_REMATCH[1] < 8192 )); then
        echo "FAIL - Bad net.core.somaxconn = ${BASH_REMATCH[1]}. Fixing."
        # Temporarily set net to 8192
        echo 8192 > /proc/sys/net/core/somaxconn

        # Scan and remove all, if any, instances of net.core/somaxconn
        sed -i -e '/^\.*net.core.somaxconn*$/d' /etc/sysctl.d/*
        sed -i -e '/^\.*net.core.somaxconn*$/d' /usr/lib/sysctl.d/*

        # Create config file with setting
        touch /etc/sysctl.d/net_core_somaxconn.conf
        echo 'net.core.somaxconn = 8192' > /etc/sysctl.d/net_core_somaxconn.conf
    else
        echo "OK - net.core.somaxconn = ${BASH_REMATCH[1]}"
    fi

}

function TEARDOWN() {
    echo "TEARDOWN - Complete"
}

SETUP
TEST
TEARDOWN
