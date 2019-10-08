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
echo 1. Cloning programming-concepts
echo -------------------
git clone git@github.com:ArthurPieri/programmimg-concepts.git

echo -------------------
echo 2. Cloning UnB
echo -------------------
git clone git@github.com:ArthurPieri/UnB.git

echo -------------------
echo 3. Cloning Gestao
echo -------------------
git clone git@github.com:ArthurPieri/Gestao.git

echo -------------------
echo 4. Cloning ChatApp-Udemy
echo -------------------
git clone git@github.com:ArthurPieri/ChatApp-udemy.git

echo -------------------
echo 5. Cloning Chatbot
echo -------------------
git clone git@github.com:ArthurPieri/chatbot.git

echo -------------------
echo 6. Cloning Site Arthur
echo -------------------
git clone git@github.com:ArthurPieri/siteArthur.git

echo -------------------
echo 7. Cloning Scripts
echo -------------------
git clone git@github.com:ArthurPieri/Scripts.git