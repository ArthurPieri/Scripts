#! /bin/bash
#
# /HEADER/
# This script is used to automaticly pull all changes from the git repository
# This script is currently on v0.1
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------

echo 'Automatic Push'
git add .
git commit -m "Automatic Push from script"
git push
echo 'Done'