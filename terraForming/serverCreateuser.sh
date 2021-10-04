#! /bin/bash

# Creating user ap
adduser ap

# Giving sudo permisions
usermod -aG sudo ap

# setting up Firewall
ufw allow OpenSSH
ufw enable

# Copying SSH keys from root to new user
rsync --archive --chown=ap:ap ~/.ssh /home/ap
