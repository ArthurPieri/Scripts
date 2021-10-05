#! /bin/bash
#
# /HEADER/
# Terra Forming Script for a digitalocean droplet
# This script is currently on v3
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------
# OS check so it only runs on GNU/Linux
#-------------------------------------------------------------------------------
    OS_CHECK=$(uname -o)
    if [ "${OS_CHECK}" != "GNU/Linux" ]
    then
        echo "This script was made for the GNU/Linux system you are using: ${OS_CHECK}"
        exit 1
    fi
#-------------------------------------------------------------------------------
# Checking with the CPU architecture is correct
#-------------------------------------------------------------------------------
    CPU_ARC_CHECK=$(uname -m)
    if [ "${CPU_ARC_CHECK}" != "x86_64" ]
    then
        echo "This script was made for x86 system, it seems you're using: ${CPU_ARC_CHECK} system"
        exit 2
    fi
#-------------------------------------------------------------------------------
# Verifying if debug mode on
#-------------------------------------------------------------------------------
    if [ "${1}" = "debug" ]
    then
        echo "Debug mode on"
        sleep 5
    # When using -x the PS4 is the variable printed to the screen wich by default is: +
    # You can change the value of PS4
        PS4='+ ${BASH_SOURCE} - line:${LINENO} : '
        echo "Test"
    # Set -x start the debug mode
        set -x
    fi
#-------------------------------------------------------------------------------
# Checking if user has runned createuser.sh first
#-------------------------------------------------------------------------------
    echo Did you run createuser.sh script first?
    read -p "Are you sure? (y or n): " -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo "Please setup the user first"
        exit 1
    fi 
#-------------------------------------------------------------------------------
# All the functions with 'f_' so there are no mistakes with variables
# Functions Declarations
#-------------------------------------------------------------------------------
    f_upgrade() {
        sudo apt update
        sudo apt upgrade -y
        sudo apt autoremove -y
        sudo apt autoclean -y
    }
#-------------------------------------------------------------------------------
# Creating SSH key
#-------------------------------------------------------------------------------
    echo -------------------
    echo 'Setting up SSH key'
    ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519_ssh -C "server@arthurpieri.com"
    eval "$(ssh-agent -s)"
    SSH_AGENT=$?
    if [ ${SSH_AGENT} -ne 0 ]
    then
        echo 'Setting ssh passphrase to ssh agent'
        ssh-add ~/.ssh/id_ed25519_ssh
    fi
    echo -------------------
#-------------------------------------------------------------------------------
# Setting up Firewall
#-------------------------------------------------------------------------------
    sudo ufw allow OpenSSH
    sudo ufw enable
#-------------------------------------------------------------------------------
# Updating and Upgrading the system
#-------------------------------------------------------------------------------
    f_upgrade
#---------------------------------------------------------------------------
# Installing ssh, Git, Curl, Tar, openvpn and nginx
#---------------------------------------------------------------------------
    sudo apt install openssh-server openssh-client git python3-pip nginx -y
    touch /boot/ssh
#-------------------------------------------------------------------------------
# Changing ufw configuration
#-------------------------------------------------------------------------------
    sudo ufw allow 'Nginx Full'
#-------------------------------------------------------------------------------
# Setting up server blocks
#-------------------------------------------------------------------------------
    echo -----------------------------------
    # It could be better to do a while loop in here, leaving only when user inputs correctly
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
    echo -----------------------------------
    echo "Creating a folder with the domain name provided"
    sudo mkdir -p /var/www/$domain_name/html
    echo "changing permisions"
    sudo chown -R $USER:$USER /var/www/$domain_name/html
    echo "ensuring permisions are correct"
    sudo chmod -R 755 /var/www/$domain_name
    echo "creating a dumb html file"
    sudo touch /var/www/$domain_name/html/index.html
    echo "<html>
    <head>
        <title>Welcome to $domain_name!</title>
    </head>
    <body>
        <h1>Success!  The $domain_name server block is working!</h1>
    </body>
    </html>" >> /var/www/$domain_name/html/index.html
    # Nginx server blocks
    echo "creating a new config file for nginx"
    sudo touch /etc/nginx/sites-available/$domain_name
    echo "server {
        listen 80;
        listen [::]:80;

        root /var/www/$domain_name/html;
        index index.html index.htm index.nginx-debian.html;

        server_name $domain_name www.$domain_name;

        location / {
                try_files $uri $uri/ =404;
        }
    }" >> /etc/nginx/sites-available/$domain_name
    echo "Creating simbolic link"
    sudo ln -s /etc/nginx/sites-available/$domain_name /etc/nginx/sites-enabled/
    
    echo "Changing nginx config"
    search="# server_names_hash_bucket_size 64;"
    replace="server_names_hash_bucket_size 64;"
    sed -i "s/$search/$replace/" /etc/nginx/nginx.conf
    
    echo "Changing max file size"
    search="http {
    "
    replace="http {
    
    client_max_body_size 5m;
    "
    sed -i "s/$search/$replace/" /etc/nginx/nginx.conf

    echo "Testing nginx config files"
    sudo nginx -t
    
    echo "Restarting Nginx"
    sudo systemctl restart nginx
#-------------------------------------------------------------------------------
# Setting Up Certbot
#-------------------------------------------------------------------------------
    echo "Installing "
    sudo apt install certbot python3-certbot-nginx

    # Checking if user made the DNS configuration
    answer='n'
    while [[ ! $answer =~ ^[Yy]$ ]]
    do 
        echo -----------------------------------
        echo "Did you point the dns from $domain_name to the correct IP?"
        echo -----------------------------------
        read answer
        echo
    done

    echo "Starting certbot"
    sudo certbot --nginx -d $domain_name -d www.$domain_name

#-------------------------------------------------------------------------------
# Creating services folder
#-------------------------------------------------------------------------------
    cd ~/
    if [ ! -d "$services" ]; then
        mkdir services
        echo creating Folder
    fi
    echo Entering folder
    cd services

#-------------------------------------------------------------------------------
# Setting Up docker Compose and docker
#-------------------------------------------------------------------------------
    echo "Download and install Docker"
    curl -sL https://get.docker.com | sh
    sudo usermod -aG docker ap

    echo "Dowloading version 2.0.1 from github"
    sudo curl -L "https://github.com/docker/compose/releases/download/2.0.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    echo "Testing the command"
    echo ---
    docker-compose --version
#-------------------------------------------------------------------------------
# Setting Up Aliases
#-------------------------------------------------------------------------------
    echo 'Setting Up atualizar'
    echo "alias atualizar='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    alias brc='chmod a+x ~/.bashrc; source ~/.bashrc' 
#-------------------------------------------------------------------------------
# Updating and Upgrading the system
#-------------------------------------------------------------------------------
    f_upgrade
#-------------------------------------------------------------------------------
# Fix broken
#-------------------------------------------------------------------------------
    sudo apt --fix-broken install -y
    
    echo "Next:"
    echo "Install wirehole (can be found in ../VPS/setup_wirehole.sh"
    echo "Install Ghost.js (can be found in ../VPS/ghostjs.sh"
    echo
    echo
    
    echo -------------------
    echo 'The end'
    echo -------------------

    # References Links
    # https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04
    # https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04
    # https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04-pt
    # https://www.santoshsrinivas.com/solving-the-maximum-file-size-error-on-ghost-nginx/