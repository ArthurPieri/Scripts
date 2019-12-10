#! /bin/bash
#
# /HEADER/
# This script should be used to deploy the complete DEV suite used in Akuntsu Technologies into
# a ubuntu computer
# This script is currently on v0.1
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
f_upgrade() {
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

# Instaling git curl and tar
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
    sudo apt install python3 -y
fi

# Installing docker
# Verifying if docker is already installed
docker -v
DOCKER_VERSION=$?
if [ ${DOCKER_VERSION} -ne 0 ]
then
    curl -sSL https://get.docker.com | sh
fi

# Installing docker-compose
# Verifying if docker-compose is already installer
docker-compose -v
DOCKER_COMPOSE_VERSION=$?
if [ ${DOCKER_COMPOSE_VERSION} -ne 0 ]
then
    sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "$(docker-compose --version)"
    sleep 10

# Updating and upgrading
    f_upgrade
fi

# Downloading node JS on docker
docker image inspect node
DOCKER_NODE=$?
if [ DOCKER_NODE -ne 0 ]
then
    docker image pull node
fi

# Downloading Alpine Linux on docker
docker image inspect alpine
DOCKER_ALPINE=$?
if [ ${DOCKER_ALPINE} -ne 0 ]
then
    docker image pull alpine
fi

# Downloading nginx on linux
docker image inspect nginx
DOCKER_NGINX=$?
if [ ${DOCKER_NGINX} -ne 0 ]
then
    docker image pull nginx
fi

# Dowloading the Golang
docker image inspect golang
DOCKER_GOLANG=$?
if [ ${DOCKER_GOLANG} -ne 0 ]
then
    docker image pull golang
fi

#-------------------------------------------------------------------------------------
# Instaling NodeJS and NPM
# Verifying if NodeJs is already instaled
node -v
NODE_VERSION=$?
if [ ${NODE_VERSION} -ne 0 ]
then 
# creating the nodejs folder 
mkdir nodejs

# entering the nodejs folder
cd ./nodejs

# Downloading nodejs source code
wget https://nodejs.org/dist/v10.6.0/node-v10.6.0-linux-x64.tar.xz

# Unpacking nodejs
tar -xvf node-v10.6.0-linux-x64.tar.xz

# entering the newly created node folder
cd node-v10.6.0-linux-x64/

# copying all the files to the /usr/local so node is available on the command line
sudo cp -R * /usr/local/

# exiting the two folders
cd ..
cd ..

# removing everything
rm -rf nodejs

f_upgrade
# verifying the node instalation
node -v
npm -v
sleep 10
fi
#-------------------------------------------------------------------------------------

# Installing mongoDb
mongo --version
MONGO_VERSION=$?
if [ ${MONGO_VERSION} -ne 0 ]
then
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
f_upgrade
sudo apt-get install -y mongodb-org
fi

#-------------------------------------
# Instaling Visual Studio Code
code -v
CODE_VERSION=$?
if [ ${CODE_VERSION} -ne 0 ]
then
# Creating the Code folder
mkdir code

# Entering the code folder
cd ./code

# Downloading code 
wget https://go.microsoft.com/fwlink/?LinkID=760868

# Installing
sudo dpkg -i code_1.25.0-1530796411_amd64.deb

# exiting the folder
cd ..

# removing instalation files
rm -rf code

f_upgrade
# Verifying the instalation
code -v
sleep 10
fi

# Instaling Ansible
#ansible --version
#ANSIBLE_VERSION=$?
#if [ ${ANSIBLE_VERSION} -ne 0 ]
#then
#    f_upgrade
#    sudo apt install software-properties-common
#    sudo apt-add-repository ppa:ansible/ansible -y
#    f_upgrade
#    sudo apt install ansible -y
#fi

# Instaling Jenkins
#JENKINS=$(service jenkins status)
#JENKIKS_VERSION=$?
#if [ ${JENKIKS_VERSION} -ne 0 ]
#then
#    wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
#    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
#    f_upgrade
#    sudo apt install jenkins -y
#fi

# Instaling Vagrant
#vagrant -v
#VAGRANT_VERSION=$?
#if [ ${VAGRANT_VERSION} -ne 0 ]
#then
#    mkdir ~/vagrant
#    cd ~/vagrant
#    sudo dpkg --configure -a
#    # Checking the OS typy 32 or 64 bits
#    OS_BIT_CHECK=$(getconf LONG_BIT)
#    if [ ${OS_BIT_CHECK} = "64" ]
#        then
#        wget https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb?_ga=2.216849558.1470554378.1515098001-1390826011.1515098001
#        mv vagrant_2.0.1_x86_64.deb?_ga=2.216849558.1470554378.1515098001-1390826011.1515098001 vagrant.deb
#        sudo dpkg -i vagrant.deb
#    else
#        wget https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_i686.deb?_ga=2.220009369.1470554378.1515098001-1390826011.1515098001
#        mv vagrant_2.0.1_i686.deb?_ga=2.220009369.1470554378.1515098001-1390826011.1515098001 vagrant32.deb
#        sudo dpkg -i vagrant32.deb
#    fi
#    cd ..
#    rm -r vagrant
#f
# Upgrade
f_upgrade
# Rebooting system
    sudo reboot
