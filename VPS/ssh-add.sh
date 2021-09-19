#! /bin/bash
#
# /HEADER/
# ssh agent start and key add Script
# This script is currently on v1
# Author: Arthur Pieri

echo --------------------
echo "Starting ssh-agent"
echo --------------------
eval `ssh-agent -s`

echo --------------------
echo "Adding private key to ssh-agent"
echo --------------------
ssh-add ~/.ssh/id_ed25519_ssh
echo --------------------