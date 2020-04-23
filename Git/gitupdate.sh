#! /bin/bash
#
# /HEADER/
# This script is used to update git scripts
# This script is currently on v0.1
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------

cd ~/code/Scripts
git pull
echo 'Update'
cp -r ~/code/Scripts/Git/* ~/.gitscripts