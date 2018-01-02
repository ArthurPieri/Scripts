#! /bin/bash

DEBUG=${1}

if [ "${DEBUG}" = "debug" ]
then
    DEBUG=true
elif [ "${DEBUG}" = "DEBUG" ]
then
    DEBUG=true
else
    DEBUG=false
fi

if ${DEBUG}
then
    echo "Debug mode ON."
    set -x
#When using -x the PS4 is the variable printed to the screen wich by default is: +
#You can change the value of PS4
    PS4='+ ${BASH_SOURCE} - line:${LINENO} : '
    echo "Test"
else
    echo "Debug mode OFF."
fi

