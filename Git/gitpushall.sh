#! /bin/bash
#
# /HEADER/
# This script is used to automaticly pull all changes from the git repository
# This script is currently on v0.1
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------
# TO DO
# - Make the script loop through the code directory and automaticaly find folders and commit
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Entering the coding folder to start pulling
cd ~/code

for dir in *; do
  echo "---------------------"
  echo "Entering folder $dir"
  echo "---------------------"
  echo " "
  cd $dir
  git add .
  git commit -m "Automatic Push from script"
  git push
  cd ..
done