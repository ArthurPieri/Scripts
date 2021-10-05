#! /bin/bash
#
# /HEADER/
# Install ghost JS
# This script is currently on v1
# Author: Arthur Pieri

#-------------------------------------------------------------------------------
# Changing Nginx config
#-------------------------------------------------------------------------------
    echo "Changing max file size"
    search="http {
    "
    replace="http {
    
    client_max_body_size 5m;
    "
    sudo sed -i "s/$search/$replace/" /etc/nginx/nginx.conf