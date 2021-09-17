#! /bin/bash
#
# /HEADER/
# ssh agent start and key add Script
# This script is currently on v1
# Author: Arthur Pieri

echo "Starting ssh-agent"
eval `ssh-agent -s`

echo "Adding private key to ssh-agent"
ssh-add ~/.ssh/id_ed25519_ssh