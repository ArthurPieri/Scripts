#! /bin/bash
#
# /HEADER/
# Vm Forming Script
# This script is currently on v2
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------
# OS check so it only runs on GNU/Linux
#-------------------------------------------------------------------------------
OS_CHECK=$(uname -o)
if [ "${OS_CHECK}" != "GNU/Linux" ]
then
    echo "This script was made for the GNU/Linux system you are using: ${OS_CHECK}"
    exit 1
fi
#-------------------------------------------------------------------------------
# Checking with the CPU architecture is correct
#-------------------------------------------------------------------------------
CPU_ARC_CHECK=$(uname -m)
if [ "${CPU_ARC_CHECK}" != "x86_64" ]
then
    echo "This script was made for x86 system, it seems you're using: ${CPU_ARC_CHECK} system"
    exit 2
fi
#-------------------------------------------------------------------------------
# Verifying if debug mode on
#-------------------------------------------------------------------------------
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
#-------------------------------------------------------------------------------
# All the functions with 'f_' so there are no mistakes with variables
# Functions Declarations
#-------------------------------------------------------------------------------
f_upgrade() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean -y
}
#-------------------------------------------------------------------------------
# Updating and Upgrading the system
#-------------------------------------------------------------------------------
f_upgrade
#-------------------------------------------------------------------------------
# Installing the APT apps
#-------------------------------------------------------------------------------

    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add - 
    echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list 
    sudo apt update && sudo apt install codium 