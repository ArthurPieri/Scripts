#! /bin/bash
#
# /HEADER/
# This script is used to automaticly pull all changes from the git repository
# This script is currently on v0.1
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------
# Entering the coding folder to start pulling
cd ~/code
# ------------------------------------------------------------------------------
cd conceitos_Programacao/
echo Conceitos programacao
git pull
echo ----------------------

cd ..
cd UnB/
echo UnB
git pull
#npm i
echo ----------------------

cd ..
cd Gestao/
echo Gestao
git pull
#npm i
echo ----------------------

cd ..
cd ChatApp-udemy/
echo Chat Uol
git pull
echo ----------------------

cd ..
cd  chatbot/
echo Chatbot
git pull
echo ---------------------

cd ..
cd siteArthur/
echo Site Arthur
git pull
echo ---------------------

cd ..
cd Scripts/
echo Usefull Scripts
git pull
echo --------------------

#cd ..
#cd atlasbot
#echo Atlas Bot
#git pull
#echo --------------------