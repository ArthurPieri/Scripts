#! /bin/bash

HOST="google.com"

ping -c 1 ${HOST} && echo "${HOST} reachable." || echo "${HOST} unreachable."

#if [ "$?" -eq "0" ]
#then
#    echo "${HOST} reachable."
#else
#    echo "${HOST} unreachable."
#fi

#Checking for a error code
#if [ "$?" -ne "0" ]
#then
#    echo "${HOST} unreachable."
#fi