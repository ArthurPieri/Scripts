#! /bin/bash
#
# /HEADER/
# Cloning all my github accounts
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
# Checking if this file is correct
#-------------------------------------------------------------------------------
echo "###########################################"
echo "Did you run 'chmod +x nomearquivo.sh?' (y or n)"
echo "###########################################"
read expermision 
if [ "$expermision" != "y" ]
then
    if [ "$expermision" != "Y" ]
    then
        echo "Please run: chmod +x terraForming.sh"
        exit 1
    fi
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
clear
f_upgrade
#-------------------------------------------------------------------------------
# Getting Username
#-------------------------------------------------------------------------------
clear
answer='n'
while [[ ! $answer =~ ^[Yy]$ ]]
do 
    echo "###########################################"
    echo Please insert your Github username here
    echo "###########################################"
    read name
    echo "###########################################"
    echo "is $name correct (y or n)?"
    echo "###########################################"
    read answer
    echo
done
#-------------------------------------------------------------------------------
# Getting user email
#-------------------------------------------------------------------------------
clear
answer='n'
while [[ ! $answer =~ ^[Yy]$ ]]
do 
    echo "###########################################"
    echo "Please insert the Github email"
    echo "###########################################"
    read email
    echo "###########################################"
    echo "is $email correct (y or n)?"
    echo "###########################################"
    read answer
    echo
done
#-------------------------------------------------------------------------------
# Printing infos
#-------------------------------------------------------------------------------
clear
echo "###########################################"
echo "The username is: $name"
echo "The user email is: $email"
echo "###########################################"
sleep 3
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
    # Instaling Node Version Manager
    #---------------------------------------------------------------------------
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
#-------------------------------------------------------------------------------
# Creating SSH keys
#-------------------------------------------------------------------------------
    echo -------------------
    echo 'Create git ssh-key'
    ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C $email
    echo -------------------
    #---------------------------------------------------------------------------
    eval "$(ssh-agent -s)"
    SSH_AGENT=$?
    if [ ${SSH_AGENT} -ne 0 ]
    then
        echo 'Setting ssh passphrase to ssh agent'
        ssh-add ~/.ssh/id_ed25519_ssh
    fi
    echo -------------------
echo "###########################################"
echo 'Setting up username and email git'
echo "###########################################"
echo 'Git email: '$email
echo "###########################################"
git config --global user.email "$email"

echo 'Git Username' $name
sleep 2
git config --global user.name "$name"

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
# Fix broken
#-------------------------------------------------------------------------------
    sudo apt --fix-broken install -y
