#! /bin/bash

#The read command accepts STDIN
#Syntax:
    # read -p "PROMPT" VARIABLE

read -p "Enter a user name: " USER
echo "Archiving user: ${USER}"

#Lock the account
passwd -l ${USER}

#Create an archive of the home directory
tar -cf /archives/${USER}.tar.gz /home/${USER}