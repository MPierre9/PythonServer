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
    function COMMAND() {
        sysctl -ap 2>/dev/null | grep net.core.somaxconn
    }
    declare -f COMMAND
    echo "EXECUTING..."
    catch out err COMMAND
    if [[ "$prc" -eq "0" && "$out" =~ "^net.core.somaxconn = ([0-9]+)$" ]] && (( ${BASH_REMATCH[1]} < 8192 ))
    then
        echo "FAIL - Bad net.core.somaxconn = ${BASH_REMATCH[1]}. Fixing."
       #scan all sysctl files comment out any line setting somaxconn, write new file with somaxconn = 8192 with comment
    else
        echo "OK - net.core.somaxconn = ${BASH_REMATCH[@]}"
    fi

}

function TEARDOWN() {
    echo "TEARDOWN - Complete"
}

SETUP
TEST
TEARDOWN
