#! /bin/bash
#
# /HEADER/
# Cloning all my github accounts
# This script is currently on v2
# Author: Arthur Pieri
#
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
# Entering the 'code' folder to start pulling
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
    echo '2. Cloning Gestao'
    echo -------------------
    git clone git@github.com:ArthurPieri/Gestao.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '3. Cloning Scripts'
    echo -------------------
    git clone git@github.com:ArthurPieri/Scripts.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '4. Cloning Nhanderu'
    echo -------------------
    git clone git@github.com:ArthurPieri/Nhanderu.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '5. Cloning Pomodoro'
    echo -------------------
    git clone git@github.com:ArthurPieri/Pomodoro.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '6. Cloning HueBot'
    echo -------------------
    git clone git@github.com:ArthurPieri/huebot.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '7. Setting up username and email git'
    echo -------------------
    echo 'Git Email'
    echo -------------------
    git config --global user.email "git@arthurpieri.com"
    echo 'Git Username'
    git config --global user.name "Arthur Pieri"

#-------------------------------------------------------------------------------
# Setting Up Aliases
    #---------------------------------------------------------------------------
    echo 'Setting up gall (gpullall)'
    cp -r ~/code/Scripts/Git ~/.gitscripts
    echo "alias gall='sh ~/.gitscripts/gitpullall.sh'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    echo 'Setting up Fire (gpushall)'
    echo "alias Fire='sh ~/.gitscripts/gitpushall.sh'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    echo 'Setting up gup (gupdate)'
    echo "alias gup='sh ~/.gitscripts/gitupdate.sh'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    alias brc='chmod a+x ~/.bashrc; source ~/.bashrc' 
