#! /bin/bash
#
# /HEADER/
# This script is used to automaticly create some aliases 
# This script is currently on v0.1
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------

echo "alias atualizar='sudo apt update && sudo apt upgrade -y'" >> ~/.bashrc

echo "alias gpull='sh ~/code/Scripts/Git/gitpush.sh'" >> ~/.bashrc

alias brc='chmod a+x ~/.bashrc; source ~/.bashrc' 