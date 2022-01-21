#! /bin/bash
#
# /HEADER/
# This script is used to automaticly pull all changes from the git repository
# This script is currently on v2
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------
# Entering the coding folder to start pulling
cd ~/code
# ------------------------------------------------------------------------------
for dir in *; do
  echo "---------------------"
  echo "Entering folder $dir"
  echo "---------------------"
  echo " "
  cd $dir
  git pull
  cd ..
done