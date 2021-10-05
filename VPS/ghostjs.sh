#! /bin/bash
#
# /HEADER/
# Install ghost JS
# This script is currently on v1
# Author: Arthur Pieri

#-------------------------------------------------------------------------------
# Create Ghostjs docker-compose file
#-------------------------------------------------------------------------------
    cd ~/services

    echo "version: '3.3'

services:
  blog:
    image: ghost:4
    restart: always
    ports:
      - 8080:2368
    volumes:
      - ~/data/content:/var/lib/ghost/content
    environment:
      # see https://ghost.org/docs/config/#configuration-options
      database__client: mysql
      database__connection__host: database
      database__connection__user: root
      database__connection__password: strong_password
      database__connection__database: ghost
      url: https://tecoblog.ddns.net
      NODE_ENV: production

  database:
    image: mysql:5.7
    restart: always
    volumes:
      - ~/data/db:/var/lib/mysql
    ports:
      - "13928:3306"
    environment:
      MYSQL_ROOT_PASSWORD: strong_password
      MYSQL_DATABASE: ghost
      MYSQL_USER: user
      MYSQL_PASSWORD: strong_password" >> ./docker-compose.yml

    # Launching ghost
    docker-compose up -d

    echo "Check if the container is running"
    docker ps

    echo "Make sure we can hit Ghost"
    curl http://localhost:8080

    # get domain name
    answer='n'
    while [[ ! $answer =~ ^[Yy]$ ]]
    do 
        echo -----------------------------------
        echo Please insert your domain name here
        echo -----------------------------------
        read domain_name
        echo "is $domain_name correct (y or n)?"
        read answer
        echo
    done

    echo "server {
    server_name  tecoblog.ddns.net;
    index index.html index.htm;
    access_log /var/log/nginx/blog.log;
    error_log  /var/log/nginx/blog-error.log error;

    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $http_host;
        proxy_pass http://127.0.0.1:8080;
        proxy_redirect off;
    }
}" || tee -a /etc/nginx/sites-available/$domain_name

    # Config link
    sudo ln -s /etc/nginx/sites-available/$domain_name /etc/nginx/sites-enabled/$domain_name

    echo "Testing nginx config"
    sudo nginx -t

    echo "Reloading nginx"
    echo "..."
    sudo nginx -s reload

    echo "Creating certificate"
    sudo certbot --nginx -d $domain_name

    echo "Reloading nginx"
    echo "..."
    sudo nginx -s reload

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