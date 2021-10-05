#! /bin/bash
#-------------------------------------------------------------------------------
# Checking if this file is correct
#-------------------------------------------------------------------------------
    echo "Did you gave executable permision to this file? (y or n)"
    read expermision
    if [ "$expermision" != "y" ]
    then
        if [ "$expermision" != "Y" ]
        then
            echo "Please run: chmod +x serverForming.sh"
            exit 1
        fi
    fi