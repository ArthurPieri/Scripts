#! /bin/bash

#This script checks if some aplication/server is up
APP="arthurpieri.com"
while ping -c 1 ${APP} >/dev/null
do
    echo "${APP} up..."
    sleep 5
done

echo "${APP} down..." 