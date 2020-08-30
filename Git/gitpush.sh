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
git add .
git commit -m "Automatic Push from script"
git push
echo ----------------------

cd ..
cd UnB/
echo UnB
git add .
git commit -m "Automatic Push from script"
git push
#npm i
echo ----------------------

cd ..
cd Gestao/
echo Gestao
git add .
git commit -m "Automatic Push from script"
git push
#npm i
echo ----------------------

cd ..
cd ChatApp-udemy/
echo Chat Uol
git add .
git commit -m "Automatic Push from script"
git push
echo ----------------------

cd ..
cd  chatbot/
echo Chatbot
git add .
git commit -m "Automatic Push from script"
git push
echo ---------------------

cd ..
cd siteArthur/
echo Site Arthur
git add .
git commit -m "Automatic Push from script"
git push
echo ---------------------

cd ..
cd Scripts/
echo Usefull Scripts
git add .
git commit -m "Automatic Push from script"
git push
echo --------------------

cd ..
cd Nhanderu
echo Nhanderu
git add .
git commit -m "Automatic Push from script"
git push
echo --------------------

cd ..
cd GlobalIP
echo GlobalIP
git add .
git commit -m "Automatic Push from script"
git push
echo --------------------

cd ..
cd richtext-editor
echo Rich Text Editor
git add .
git commit -m "Automatic push from script"
git push
echo -------------------

cd ..
cd Pomodoro
echo Pomodoro
git add .
git commit -m "Automatic push from script"
git push
echo -------------------