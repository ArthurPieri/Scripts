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
git add .
git commit -m "Automatic Push from script"
git push
echo ----------------------

cd ..
cd Gestao/
echo ----------------------
echo Gestao
echo ----------------------
git add .
git commit -m "Automatic Push from script"
git push
echo ----------------------

cd ..
cd Scripts/
echo ----------------------
echo Usefull Scripts
echo ----------------------
git add .
git commit -m "Automatic Push from script"
git push
echo --------------------

cd ..
cd Nhanderu
echo ----------------------
echo Nhanderu
echo ----------------------
git add .
git commit -m "Automatic Push from script"
git push
echo --------------------

cd ..
cd Pomodoro
echo ----------------------
echo Pomodoro
echo ----------------------
git add .
git commit -m "Automatic push from script"
git push
echo -------------------

cd ..
cd huebot
echo ----------------------
echo HUe Bot
echo ----------------------
git add .
git commit -m "Automatic push from script"
git push
echo -------------------

cd ..
cd Tretori_cadastro
echo -------------------
echo Tretori
echo -------------------
git add .
git commit -m "Automatic push from script"
git push
echo -------------------