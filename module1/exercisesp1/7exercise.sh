#! /bin/bash

if [ -e $1 ] 
then
    echo "The name is a for a File"
elif [ -d $1 ]
then
    echo "The name is for a directory"
else
    echo "The name is for something else"
fi

ls -la