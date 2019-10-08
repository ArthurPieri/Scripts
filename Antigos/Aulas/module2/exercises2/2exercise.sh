#! /bin/bash

read -p "Enter the file name: " FILE_NAME

if [ -e ${FILE_NAME} ] 
then
    echo "The name is a for a File"
    exit 0
elif [ -d ${FILE_NAME} ]
then
    echo "The name is for a directory"
    exit 1
else
    echo "The name is for something else"
    exit 2
fi