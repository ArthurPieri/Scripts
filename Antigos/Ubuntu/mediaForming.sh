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
# All the functions with 'f_' so there are no mistakes with variables
# Functions Declarations
#-------------------------------------------------------------------------------
f_upgrade() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean
}
#-------------------------------------------------------------------------------
# Updating and Upgrading the system
#-------------------------------------------------------------------------------
f_upgrade
#-------------------------------------------------------------------------------
# Installing the APT apps
#-------------------------------------------------------------------------------
    #---------------------------------------------------------------------------
    # Instaling Python 3
    #---------------------------------------------------------------------------
    python --version
    PYTHON_VERSION=$?
    if [ ${PYTHON_VERSION} -ne 0 ]
    then
        sudo apt install python3 python3-pip python3-setuptools -y
    fi
    #---------------------------------------------------------------------------
    # Installing protonvpn
    #---------------------------------------------------------------------------  
    sudo apt install openvpn network-manager-openvpn-gnome resolvconf dialog -y
    sudo pip3 install protonvpn-cli
#-------------------------------------------------------------------------------
# Setting Up Aliases
    echo 'Setting Up Atualizar'
    echo "alias atualizar='sudo apt update && sudo apt upgrade -y && sudo apt autoremove'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    alias brc='chmod a+x ~/.bashrc; source ~/.bashrc' 
#-------------------------------------------------------------------------------
# Updating and Upgrading the system
#-------------------------------------------------------------------------------
    f_upgrade
#-------------------------------------------------------------------------------
# Removing initrams
#-------------------------------------------------------------------------------
    sudo apt remove flash-kernel initramfs-tools
#-------------------------------------------------------------------------------
# Fix broken
#-------------------------------------------------------------------------------
    sudo apt --fix-broken install -y
