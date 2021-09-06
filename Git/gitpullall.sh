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
echo ----------------------
echo Conceitos programacao
echo ----------------------
git pull
echo ----------------------

cd ..
cd Gestao/
echo ----------------------
echo Gestao
echo ----------------------
git pull
#npm i
echo ----------------------

cd ..
cd Scripts/
echo ----------------------
echo Usefull Scripts
echo ----------------------
git pull
echo --------------------

cd ..
cd Pomodoro
echo ----------------------
echo Pomodoro
echo ----------------------
git pull
echo -------------------

cd ..
cd Nhanderu
echo ----------------------
echo Nhanderu
echo ----------------------
git pull
echo -------------------

cd ..
cd huebot
echo ----------------------
echo HUE Bot
echo ----------------------
git pull
echo -------------------

cd ..
cd Tretori_cadastro
echo -------------------
echo Tretori
echo -------------------
git pull
echo -------------------