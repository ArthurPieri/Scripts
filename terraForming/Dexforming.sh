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
    # Installing ssh, Git, Curl, Tar
    #---------------------------------------------------------------------------
    sudo apt install curl wget openssh-server openssh-client git tar silversearcher-ag -y
    touch /boot/ssh
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
    # Instaling Code
    #---------------------------------------------------------------------------
    wget https://github.com/cdr/code-server/releases/download/2.1698/code-server2.1698-vsc1.41.1-linux-arm64.tar.gz
    tar -xvf ./code-server2.1698-vsc1.41.1-linux-arm64.tar.gz
    cp ./code-server2.1698-vsc1.41.1-linux-arm64/code-server /bin

#-------------------------------------------------------------------------------
# Creating SSH keys
#-------------------------------------------------------------------------------
    echo -------------------
    echo 'Create git ssh-key'
    ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "git@arthurpieri.com"
    echo -------------------
    #---------------------------------------------------------------------------
    echo -------------------
    echo 'Setting up SSH keys'
    ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519_ssh -C "ssh@arthurpieri.com"
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
