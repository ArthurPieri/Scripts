#! /bin/bash
#
# /HEADER/
# This script is currently on v0.9
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------------
# OS check so it only runs on GNU/Linux
OS_CHECK=$(uname -o)
if [ "${OS_CHECK}" != "GNU/Linux" ]
then
    echo "This script was made for the GNU/Linux system you are using: ${OS_CHECK}"
    exit 1
fi
#-------------------------------------------------------------------------------------#
# Checking with the CPU architecture is correct
CPU_ARC_CHECK=$(uname -m)
if [ "${CPU_ARC_CHECK}" != "x86_64" ]
then
    echo "This script was made for x86 system, it seems you're using: ${CPU_ARC_CHECK} system"
    exit 2
fi
#-------------------------------------------------------------------------------------
# Verifying if debug mode on
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
#-------------------------------------------------------------------------------------
# All the functions with 'f_' so there are no mistakes with variables
# Functions Declarations
f_upgrade()  {
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean
}
# End of Functions Declaration
#---------------------------------------------------------

# Updating and Upgrading the system
f_upgrade
# Installing ssh
    sudo apt install openssh-server openssh-client -y
    touch /boot/ssh

# Instaling git
git --version
GIT_VERSION=$?
if [ ${GIT_VERSION} -ne 0 ]
then
    sudo apt install git -y
fi

# Instaling tar, curl and wget
tar --version
TAR_VERSION=$?
if [ ${TAR_VERSION} -ne 0 ]
then
    sudo apt install tar -y
fi

curl --version
CURL_VERSION=$?
if [ ${TAR_VERSION} -ne 0 ]
then
    sudo apt install curl -y
fi

wget --version
WGET_VERSION=$?
if [ ${WGET_VERSION} -ne 0 ]
then
    sudo apt install wget -y
fi

python --version
PYTHON_VERSION=$?
if [ ${PYTHON_VERSION} -ne 0 ]
then
    sudo apt install python -y
fi

# Installing nodejs
node -v
NODE_VERSION=$?
if [ ${NODE_VERSION} -ne 0 ]
then
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Installing Visual studio code
code -v
CODE_VERSION=$?
if [ ${CODE_VERSION} -ne 0 ]
then
    sudo snap install vscode --classic
fi

# Installing chrome
google-chrome --version
CHROME_VERSION=$?
if [ ${CHROME_VERSION} -ne 0 ]
then
    mkdir chrome
    cd chrome
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    cd ..
    rm -rf chrome
fi

# Installing Postgresql 9.4
#    sudo apt remove -y postgresql*
#    sudo apt install -y postgresql-9.4

# Installing PGADMIN 4
#    cd ~/
#sudo apt install -y virtualenv python-pip libpq-dev python-dev pgadmin4

# Updating and upgrading
    f_upgrade

# Installing docker
# Verifying if docker is already installed
docker -v
DOCKER_VERSION=$?
if [ ${DOCKER_VERSION} -ne 0 ]
then
    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    sudo apt update
    sudo apt install docker-ce
fi

# Downloading node JS on docker
docker image inspect node
DOCKER_NODE=$?
if [ DOCKER_NODE -ne 0 ]
then
   sudo docker image pull node
fi

# Downloading Alpine Linux on docker
docker image inspect alpine
DOCKER_ALPINE=$?
if [ ${DOCKER_ALPINE} -ne 0 ]
then
   sudo docker image pull alpine
fi

# Downloading nginx on linux
docker image inspect nginx
DOCKER_NGINX=$?
if [ ${DOCKER_NGINX} -ne 0 ]
then
   sudo docker image pull nginx
fi

# Updating and upgrading
    f_upgrade
    exit 0
