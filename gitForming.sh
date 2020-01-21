#! /bin/bash
#
# /HEADER/
# Cloning all my github accounts
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
# Verifying if git exists on the computer
#-------------------------------------------------------------------------------
git --version
GIT_VERSION=$?
if [ ${GIT_VERSION} -ne 0 ]
then
    exit 1
fi
#-------------------------------------------------------------------------------
# Entering the coding folder to start pulling
#-------------------------------------------------------------------------------
cd ~/
if [ ! -d "$code" ]; then
    mkdir code
    echo creating Folder
fi
echo Entering folder
cd code
    #---------------------------------------------------------------------------
    echo -------------------
    echo '1. Cloning Conceitos Programacao'
    echo -------------------
    git clone git@github.com:ArthurPieri/conceitos_Programacao.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '2. Cloning UnB'
    echo -------------------
    git clone git@github.com:ArthurPieri/UnB.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '3. Cloning Gestao'
    echo -------------------
    git clone git@github.com:ArthurPieri/Gestao.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '4. Cloning ChatApp-Udemy'
    echo -------------------
    git clone git@github.com:ArthurPieri/ChatApp-udemy.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '5. Cloning Chatbot'
    echo -------------------
    git clone git@github.com:ArthurPieri/chatbot.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '6. Cloning Site Arthur'
    echo -------------------
    git clone git@github.com:ArthurPieri/siteArthur.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '7. Cloning Scripts'
    echo -------------------
    git clone git@github.com:ArthurPieri/Scripts.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '8. Cloning ArthurPieri.github.io'
    echo -------------------
    git clone git@github.com:ArthurPieri/ArthurPieri.github.io.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '9. Cloning GlobalIP'
    echo -------------------
    git clone git@github.com:ArthurPieri/GlobalIP.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '10. Setting up username and email git'
    echo -------------------
    echo 'Git Email'
    echo -------------------
    git config --global user.email "git@arthurpieri.com"
    echo 'Git Username'
    git config --global user.name "Arthur Pieri"

#-------------------------------------------------------------------------------
# Setting Up Aliases
    #---------------------------------------------------------------------------
    echo 'Setting up gpull'
    cp -r ~/code/Scripts/Git ~/.gitscripts
    echo "alias gpull='sh ~/.gitscripts/gitpull.sh'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    echo 'Setting up gpush'
    echo "alias gpush='sh ~/gitscripts/gitpush.sh'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    alias brc='chmod a+x ~/.bashrc; source ~/.bashrc' 
