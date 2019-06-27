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
else
    cd code
fi
#-------------------------------------------------------------------------------
git clone 
