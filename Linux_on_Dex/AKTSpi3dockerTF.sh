#! /bin/bash
#
# /HEADER/
# This script should be used to deploy the complete DEV suite used in Akunts Technologies into
# a raspberry pi 3
# This script is currently on v0.1
# Author: Arthur Pieri
#
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
# Variables declaration
USER=$(users)
# All the functions with 'f_' so there are no mistakes with variables
# Functions Declarations
function f_upgrade () {
    sudo apt update -y
    sudo apt upgrade -y
}
# End of Functions Declaration
#---------------------------------------------------------
if [ "${USER}" != "pi" ]
then
# Deleting user pi
    sudo deluser pi
    sudo rm -rf /home/pi
fi
# Updating and Upgrading the system
f_upgrade
# Installing ssh
    sudo apt install openssh-server openssh-client -
    touch /boot/ssh
# Instaling git curl and tar
    sudo apt install git -y
# Instaling tar, curl, wget and python
    sudo apt install tar curl wget python -y
# Installing docker
    curl -sSL https://get.docker.com | sh
# Installing docker-machine
    base=https://github.com/docker/machine/releases/download/v0.16.0 &&
    curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
    sudo install /tmp/docker-machine /usr/local/bin/docker-machine
# Installing docker compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
# Updating and upgrading
    f_upgrade
# Downloading node JS on docker
    docker image pull node
# Downloading mongoDB on docker
    docker image pull mongo
# Downloading Alpine Linux on docker
    docker image pull alpine
# Downloading nginx on linux
    docker image pull nginx
# Rebooting system
    sudo reboot