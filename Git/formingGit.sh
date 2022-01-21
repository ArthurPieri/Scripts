#! /bin/bash
#
# /HEADER/
# Cloning all my github accounts
# This script is currently on v3
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------
# Verifying if git exists on the computer
#-------------------------------------------------------------------------------
echo "###########################################"
git --version
echo "###########################################"
GIT_VERSION=$?
if [ ${GIT_VERSION} -ne 0 ]
then
sudo apt install git
fi
#-------------------------------------------------------------------------------
# Creating 'code' Folder
#-------------------------------------------------------------------------------
clear
cd ~/
if [ ! -d "$code" ]; then
    mkdir code
    echo "###########################################"
    echo "creating Folder code"
fi
echo "###########################################"
echo "Entering code"
cd code

#-------------------------------------------------------------------------------
# Checking if this file is correct
#-------------------------------------------------------------------------------
echo "###########################################"
echo "Did you make this file executable? (y or n)"
echo "###########################################"
read expermision 
if [ "$expermision" != "y" ]
then
    if [ "$expermision" != "Y" ]
    then
        echo "Please run: chmod +x serverForming.sh"
        exit 1
    fi
fi
#-------------------------------------------------------------------------------
# Getting Username
#-------------------------------------------------------------------------------
clear
answer='n'
while [[ ! $answer =~ ^[Yy]$ ]]
do 
    echo "###########################################"
    echo Please insert your username here
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
    echo "Please insert the user email"
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
# Cloning repos
#-------------------------------------------------------------------------------

curl "https://api.github.com/users/$name/repos?page=1&per_page=100" | grep -e 'git_url*' | cut -d \" -f 4 | xargs -L1 git clone

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
#---------------------------------------------------------------------------
clear
answer='n'
echo "###########################################"
echo "Do you want to create the Aliases?"
echo "###########################################"
read answer
if [ "$answer" != "y" ]
    then
        if [ "$answer" != "Y" ]
        then
            echo "###########################################"
            echo "Skiping aliases"
            echo "###########################################"
            sleep 3
            exit 0
        fi
fi

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

exit 0