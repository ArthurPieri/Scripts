#! /bin/bash
#
# /HEADER/
# Terra Forming Script for a digitalocean droplet
# This script is currently on v3
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
# Checking if user has runned createuser.sh first
#-------------------------------------------------------------------------------
    echo Did you run createuser.sh script first?
    read -p "Are you sure? (y or n): " -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
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
        sudo apt autoclean -y
    }
#-------------------------------------------------------------------------------
# Creating services folder
#-------------------------------------------------------------------------------
    cd ~/
    if [ ! -d "$services" ]; then
        mkdir services
        echo creating Folder
    fi
    echo Entering folder
    cd services
#-------------------------------------------------------------------------------
# Setting up Firewall
#-------------------------------------------------------------------------------
    ufw allow OpenSSH
    ufw enable
#-------------------------------------------------------------------------------
# Updating and Upgrading the system
#-------------------------------------------------------------------------------
    f_upgrade
#---------------------------------------------------------------------------
# Installing ssh, Git, Curl, Tar, openvpn and nginx
#---------------------------------------------------------------------------
    sudo apt install openssh-server openssh-client git python3-pip nginx -y
    touch /boot/ssh
#-------------------------------------------------------------------------------
# Changing ufw configuration
#-------------------------------------------------------------------------------
    sudo ufw allow 'Nginx Full'
#-------------------------------------------------------------------------------
# Creating SSH key
#-------------------------------------------------------------------------------
    echo -------------------
    echo 'Setting up SSH key'
    ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519_ssh -C "server@arthurpieri.com"
    eval "$(ssh-agent -s)"
    SSH_AGENT=$?
    if [ ${SSH_AGENT} -ne 0 ]
    then
        echo 'Setting ssh passphrase to ssh agent'
        ssh-add ~/.ssh/id_ed25519_ssh
    fi
    echo -------------------
#-------------------------------------------------------------------------------
# Setting Up Aliases
    echo 'Setting Up Atualizar'
    echo "alias atualizar='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    alias brc='chmod a+x ~/.bashrc; source ~/.bashrc' 
#-------------------------------------------------------------------------------
# Updating and Upgrading the system
#-------------------------------------------------------------------------------
    f_upgrade
#-------------------------------------------------------------------------------
# Fix broken
#-------------------------------------------------------------------------------
    sudo apt --fix-broken install -y
    echo -------------------
    echo 'The end'
    echo -------------------