#! /bin/bash
#
# /HEADER/
# This script is used to automaticly clone all repositories from the git 
# This script is currently on v0.1
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------
# Entering the coding folder to start pulling
cd ~/
if [ ! -d "$code" ]; then
    mkdir code
    echo creating Folder
fi
# Entering the Folder
echo Entering folder
cd code

#-------------------------------------------------------------------------------
echo -------------------
echo Cloning Agilidade
echo -------------------
git clone git@github.com:ArthurPieri/Agilidade.git

echo -------------------
echo Cloning Chat app Udemy
echo -------------------
git clone git@github.com:ArthurPieri/ChatApp-udemy.git

echo -------------------
echo Cloning ModernJSBootcamp
echo -------------------
git clone git@github.com:ArthurPieri/ModernJSBootcamp.git

echo -------------------
echo Cloning Node Js Alura
echo -------------------
git clone git@github.com:ArthurPieri/nodejsAlura.git

echo -------------------
echo Cloning Web Dev Bootcamp
echo -------------------
git clone git@github.com:ArthurPieri/WebDevBootcamp.git

echo -------------------
echo Cloning Arthur Pieri Site
echo -------------------
git clone git@github.com:ArthurPieri/arthurpieriSite.git

echo -------------------
echo Cloning Shell Scripting
echo -------------------
git clone git@gitlab.com:arthurpieri/shellScripting.git