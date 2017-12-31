#! /bin/bash

read -p "Enter the file name: " FILE_NAME

if [ -e ${FILE_NAME} ] 
then
    echo "The name is a for a File"
elif [ -d ${FILE_NAME} ]
then
    echo "The name is for a directory"
else
    echo "The name is for something else"
fi

ls -la