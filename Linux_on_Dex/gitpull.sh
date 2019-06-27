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
cd Agilidade/
echo Agilidade
git pull
echo ----------------------

cd ..
cd shellScripting/
echo shellScripting
git pull
#npm i
echo ----------------------

cd ..
cd ChatApp-udemy
echo ChatApp
git pull
#npm i
echo ----------------------

cd ..
cd WebDevBootcamp
echo Web Developer Bootcamp
git pull
echo ----------------------

cd ..
cd  arthurpieriSite
echo Site arthurpieri.com
git pull
echo ---------------------

cd ..
cd nodejsAlura
echo Alura Nodejs
git pull
echo ---------------------
