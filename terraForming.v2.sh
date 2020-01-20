#! /bin/bash
#
# /HEADER/
# Terra Forming Script
# This script is currently on v0.1
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
# All the functions with 'f_' so there are no mistakes with variables
# Functions Declarations
#-------------------------------------------------------------------------------
f_upgrade() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean
}
#-------------------------------------------------------------------------------
# End of Functions Declaration
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Updating and Upgrading the system
#-------------------------------------------------------------------------------
f_upgrade
#-------------------------------------------------------------------------------
# Installing the APT apps
#-------------------------------------------------------------------------------
    #---------------------------------------------------------------------------
    # Installing ssh, Git, Curl, Tar
    #---------------------------------------------------------------------------
    sudo apt install curl wget openssh-server openssh-client git tar -y
    touch /boot/ssh
    #---------------------------------------------------------------------------
    # Instaling Python 2 and 3
    #---------------------------------------------------------------------------
    python --version
    PYTHON_VERSION=$?
    if [ ${PYTHON_VERSION} -ne 0 ]
    then
        sudo apt install python3 python3-pip python3-setuptools -y
    fi
    #---------------------------------------------------------------------------
    # Installing R
    #---------------------------------------------------------------------------
    R --version
    R_VERSION=$?
    if [ $R_VERSION -ne 0 ]
    then
        sudo apt install r-base -y
        sudo apt install r-base-dev -y    
    fi
    #---------------------------------------------------------------------------
    # Installing protonvpn
    #---------------------------------------------------------------------------  
    sudo apt install openvpn network-manager-openvpn-gnome resolvconf dialog -y
    sudo pip3 install protonvpn-cli
    #---------------------------------------------------------------------------
    # Installing Gnome Tweak tool
    # For Dark mode
    #---------------------------------------------------------------------------
    sudo apt install gnome-tweak-tool -y
    #---------------------------------------------------------------------------
    # Installing code
    #---------------------------------------------------------------------------  
    sudo snap install code --classic
    #---------------------------------------------------------------------------
    # Installing Gnome boxes
    #---------------------------------------------------------------------------  
    sudo apt install gnome-boxes
    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock
#-------------------------------------------------------------------------------
# Creating the folder for save the files
#-------------------------------------------------------------------------------
mkdir ~/Downloads/ifiles
cd ~/Downloads/ifiles
    #---------------------------------------------------------------------------
    # Installing docker
    #---------------------------------------------------------------------------
    docker -v
    DOCKER_VERSION=$?
    if [ ${DOCKER_VERSION} -ne 0 ]
    then
        echo 'Installing Docker'
        curl -sSL https://get.docker.com | sh
    fi
    #---------------------------------------------------------------------------
    # Installing docker-compose
    #---------------------------------------------------------------------------
    docker-compose -v
    DOCKER_COMPOSE_VERSION=$?
    if [ ${DOCKER_COMPOSE_VERSION} -ne 0 ]
    then
        echo 'Installing Docker Compose'
        sudo curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        echo "$(docker-compose --version)"
        sleep 10
    fi
    #---------------------------------------------------------------------------
    # Download and Install RStudio
    #---------------------------------------------------------------------------
    wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb
    sudo dpkg -i rstudio-*
    #---------------------------------------------------------------------------
    # Installing NVM
    nvm -v 
    NVM_VERSION=$?
    if [ $NVM_VERSION -ne 0 ]
    then
        sudo apt install build-essential libssl-dev -y
        wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
    fi
    #---------------------------------------------------------------------------
    # Installing Node via NVM
    #---------------------------------------------------------------------------
    node -v
    NODE_VERSION=$?
    if [ $NODE_VERSION -ne 0 ]
    then
        nvm install node
        nvm use node
    fi
#-------------------------------------------------------------------------------
# Deleting all the downloaded Files
#-------------------------------------------------------------------------------
cd ~/Downloads/
rm -rf ~/Downloads/ifiles
#-------------------------------------------------------------------------------
# Entering the coding folder to start pulling
#-------------------------------------------------------------------------------
cd ~/
if [ ! -d "$code" ]; then
    mkdir code
    echo creating Folder
fi
# Entering the Folder
echo Entering folder
cd code
    #---------------------------------------------------------------------------
    echo -------------------
    echo '1. Cloning Conceitos Programacao'
    echo -------------------
    git clone git@github.com:ArthurPieri/conceitos_Programacao.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '2. Cloning UnB'
    echo -------------------
    git clone git@github.com:ArthurPieri/UnB.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '3. Cloning Gestao'
    echo -------------------
    git clone git@github.com:ArthurPieri/Gestao.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '4. Cloning ChatApp-Udemy'
    echo -------------------
    git clone git@github.com:ArthurPieri/ChatApp-udemy.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '5. Cloning Chatbot'
    echo -------------------
    git clone git@github.com:ArthurPieri/chatbot.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '6. Cloning Site Arthur'
    echo -------------------
    git clone git@github.com:ArthurPieri/siteArthur.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '7. Cloning Scripts'
    echo -------------------
    git clone git@github.com:ArthurPieri/Scripts.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '8. Cloning ArthurPieri.github.io'
    echo -------------------
    git clone git@github.com:ArthurPieri/ArthurPieri.github.io.git
    #---------------------------------------------------------------------------
    echo -------------------
    echo '9. Cloning GlobalIP'
    echo -------------------
    git clone git@github.com:ArthurPieri/GlobalIP.git
    #---------------------------------------------------------------------------


    echo -------------------
    echo '10. Setting up username and email git'
    echo -------------------
    echo 'Git Email'
    echo --------
    git config --global user.email "arthur@arthurpieri.com"
    echo 'Git Username'
    git config --global user.name "Arthur Pieri"
    #---------------------------------------------------------------------------
    echo -------------------
    echo 'The end'
    echo -------------------
#-------------------------------------------------------------------------------
# Setting Up Aliases
    echo 'Setting Up Atualizar'
    echo "alias atualizar='sudo apt update && sudo apt upgrade -y'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    echo 'Setting up gpull'
    echo "alias gpull='sh ~/code/Scripts/Git/gitpull.sh'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    echo 'Setting up gpush'
    echo "alias gpush='sh ~/code/Scripts/Git/gitpush.sh'" >> ~/.bashrc
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
