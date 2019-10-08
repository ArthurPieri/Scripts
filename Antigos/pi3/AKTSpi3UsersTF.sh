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
# Variables declarations
PI_PASSWORD="STKA$(date +%y-%m-%d-%T)${0}"
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
# All the functions with 'f_' so there are no mistakes with variables
# Functions Declarations
function f_upgrade () {
    sudo apt update -y
    sudo apt upgrade -y
}
# End of Functions Declaration
#---------------------------------------------------------
# Changing password and locking it down
    echo "pi:${PI_PASSWORD}" | sudo chpasswd
    passwd -l pi
# Creating new User
    sudo adduser akts --shell /bin/bash --ingroup sudo
    echo "akts:stka@terraformation@2018" | sudo chpasswd
    touch /boot/ssh
#-------------------------------------------------------------------------------------
# Updating and Upgrading the system
f_upgrade
# Rebooting system to aply changes
sudo reboot