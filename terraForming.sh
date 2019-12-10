#! /bin/bash
#
# /HEADER/
# Terra Forming Script
# This script is currently on v0.1
# Author: Arthur Pieri
#
#-------------------------------------------------------------------------------
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

#-------------------------------------------------------------------------------------
# Creating the folder for save everything
mkdir ~/Downloads/ifiles
cd ~/Downloads/ifiles

# Installing ssh
echo 'Installing SSH'
sudo apt install openssh-server openssh-client -y
touch /boot/ssh

# Instaling git curl and tar
git --version
GIT_VERSION=$?
if [ ${GIT_VERSION} -ne 0 ]
then
    echo 'Installing Git'
    sudo apt install git -y
fi

# Instaling tar, curl and wget
tar --version
TAR_VERSION=$?
if [ ${TAR_VERSION} -ne 0 ]
then
    echo 'Installing Tar'
    sudo apt install tar -y
fi

curl --version
CURL_VERSION=$?
if [ ${TAR_VERSION} -ne 0 ]
then
    echo ' Installing curl'
    sudo apt install curl -y
fi

wget --version
WGET_VERSION=$?
if [ ${WGET_VERSION} -ne 0 ]
then
    echo 'Installing Wget'
    sudo apt install wget -y
fi

python --version
PYTHON_VERSION=$?
if [ ${PYTHON_VERSION} -ne 0 ]
then
    echo 'Installing Python'
    sudo apt install python -y
    echo 'Installing Python 3'
    sudo apt install python3 -y
fi

# Installing docker
# Verifying if docker is already installed
docker -v
DOCKER_VERSION=$?
if [ ${DOCKER_VERSION} -ne 0 ]
then
    echo 'Installing Docker'
    curl -sSL https://get.docker.com | sh
fi

# Installing docker-compose
# Verifying if docker-compose is already installer
docker-compose -v
DOCKER_COMPOSE_VERSION=$?
if [ ${DOCKER_COMPOSE_VERSION} -ne 0 ]
then
    echo 'Installing Docker Compose'
    sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "$(docker-compose --version)"
    sleep 10

# Updating and upgrading
    f_upgrade
fi

#-------------------------------------------------------------------------------------
# Installing R
R --version
R_VERSION=$?
if [ $R_VERSION -ne 0 ]
then
    sudo apt install r-base
    sudo apt install r-base-dev    
fi

#-------------------------------------------------------------------------------------
# Download and Install RStudio
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5019-amd64.deb
sudo dpkg -i rstudio-*

#-------------------------------------------------------------------------------------
# Installing NVM
nvm -v 
NVM_VERSION=$?
if [ $NVM_VERSION -ne 0 ]
then
    sudo apt install build-essential libssl-dev -y
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
fi

# Installing Node via NVM
node -v
NODE_VERSION=$?
if [ $NODE_VERSION -ne 0 ]
then
    nvm install node
    nvm use node
fi

# Installing VScode
#-------------------------------------------------------------------------------------
code -v
CODE_VERSION=$?
if [ $CODE_VERSION -ne 0 ]
then
curl -sSL https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i code*
fi

# Installing Stremio
#-------------------------------------------------------------------------------------  
curl -sSL https://dl.strem.io/linux/v4.4.54/stremio_4.4.52-1_amd64.deb
sudo dpkg -i stremio_4.4.52-1_amd64.deb

# Installing Brave Browser
#-------------------------------------------------------------------------------------  
sudo apt install apt-transport-https curl -y
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
alias brcc='chmod a+x /etc/os-release; source /etc/os-release'
brcc
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ eoan main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list
sudo apt update
sudo apt install brave-browser

# Deleting all the downloaded Files
#-------------------------------------------------------------------------------------  
cd ~/Downloads/
rm -rf ~/Downloads/ifiles

#-------------------------------------------------------------------------------------
# Entering the coding folder to start pulling
cd ~/
if [ ! -d "$code" ]; then
    mkdir code
    echo creating Folder
fi
# Entering the Folder
echo Entering folder
cd code

#-------------------------------------------------------------------------------
echo -------------------
echo '1. Cloning Conceitos Programacao'
echo -------------------
git clone git@github.com:ArthurPieri/conceitos_Programacao.git

echo -------------------
echo '2. Cloning UnB'
echo -------------------
git clone git@github.com:ArthurPieri/UnB.git

echo -------------------
echo '3. Cloning Gestao'
echo -------------------
git clone git@github.com:ArthurPieri/Gestao.git

echo -------------------
echo '4. Cloning ChatApp-Udemy'
echo -------------------
git clone git@github.com:ArthurPieri/ChatApp-udemy.git

echo -------------------
echo '5. Cloning Chatbot'
echo -------------------
git clone git@github.com:ArthurPieri/chatbot.git

echo -------------------
echo '6. Cloning Site Arthur'
echo -------------------
git clone git@github.com:ArthurPieri/siteArthur.git

echo -------------------
echo '7. Cloning Scripts'
echo -------------------
git clone git@github.com:ArthurPieri/Scripts.git

echo -------------------
echo '8. Setting up username and email git'
echo -------------------
echo 'Git Email'
echo --------
git config --global user.email "arthur@arthurpieri.com"
echo 'Git Username'
git config --global user.name "Arthur Pieri"

echo -------------------
echo 'The end'
echo -------------------

#-------------------------------------------------------------------------------------
# Setting Up Aliases
echo 'Setting Up Atualizar'
echo "alias atualizar='sudo apt update && sudo apt upgrade -y'" >> ~/.bashrc

echo 'Setting up gpull'
echo "alias gpull='sh ~/code/Scripts/Git/gitpull.sh'" >> ~/.bashrc

echo 'Setting up gpush'
echo "alias gpush='sh ~/code/Scripts/Git/gitpush.sh'" >> ~/.bashrc

alias brc='chmod a+x ~/.bashrc; source ~/.bashrc' 

f_upgrade