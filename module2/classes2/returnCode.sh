#! /bin/bash

HOST="googdle.com"

ping -c 1 ${HOST}
#if [ "$?" -eq "0" ]
#then
#    echo "${HOST} reachable."
#else
#    echo "${HOST} unreachable."
#fi

#Checking for a error code
if [ "$?" -ne "0" ]
then
    echo "${HOST} unreachable."
fi