#! /bin/bash

# /HEADER/
# This script should be used to deploy Nodejs on a raspberry pi 3
# This script is currently on v1.0
# Author: Arthur Pieri

#-------------------------------------------------------------------------------------
# OS check so it only runs on GNU/Linux
OS_CHECK=$(uname -o)
if [ "${OS_CHECK}" != "GNU/Linux" ]
then
    echo "This script was made for the GNU/Linux system you are using: ${OS_CHECK}"
    exit 1
fi
#-------------------------------------------------------------------------------------#
# Checking with the CPU architecture is correct
CPU_ARC_CHECK=$(uname -m)
if [ "${CPU_ARC_CHECK}" != "armv7l" ]
then
    echo "This script was made for a RaspberryPi3 (armv7), it seems you're using: ${CPU_ARC_CHECK} system"
    exit 2
fi
#-------------------------------------------------------------------------------------
# Verifying if debug mode on
if [ "${1}" = "debug" ]
then
    echo "Debug mode on"
    sleep 5
# When using -x the PS4 is the variable printed to the screen wich by default is: +
# You can change the value of PS4
    PS4='+ ${BASH_SOURCE} - line:${LINENO} : '
    echo "Test"
# Set -x start the debug mode
    set -x
fi
#-------------------------------------------------------------------------------------
# Installing nodejs on raspberry pi
# creating the nodejs folder 
mkdir nodejs
# entering the nodejs folder
cd ./nodejs

# Downloading nodejs source code
wget https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-armv7l.tar.xz

# Unpacking nodejs
tar -xvf node-v8.9.5-linux-armv7l.tar.xz

# entering the newly created node folder
cd node-v8.9.4-linux-armv7l/

# copying all the files to the /usr/local so node is available on the command line
sudo cp -R * /usr/local/

# exiting the two folders
cd ..
cd ..

# removing everything
rm -rv nodejs

# verifying the node instalation
node -v
sleep 10
sudo apt update
sudo apt upgrade
sudo reboot
#------------------------------------------------------------------
