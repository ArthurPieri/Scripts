#! /bin/bash
#
# /HEADER/
# Vm Forming Script
# This script is currently on v2
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
    sudo apt autoclean -y
}
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
    sudo apt install curl wget openssh-server openssh-client git tar silversearcher-ag -y
    touch /boot/ssh
    #---------------------------------------------------------------------------
    # Installing Icon pack and Fonts
    #---------------------------------------------------------------------------
    sudo add-apt-repository ppa:daniruiz/flat-remix
    sudo apt-get update
    sudo apt install flat-remix-gtk fonts-hack-ttf -y
    #---------------------------------------------------------------------------
    # Instaling Python 3
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
    # Installing code and heroku
    #---------------------------------------------------------------------------  
    sudo snap install code --classic
    sudo snap install --classic heroku
    #---------------------------------------------------------------------------
    # Download and Install asdf and ubuntu make
    #---------------------------------------------------------------------------
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.6
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
    echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
    sudo snap install ubuntu-make --classic
#-------------------------------------------------------------------------------
# Creating the folder to save the files
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
# Creating SSH keys
#-------------------------------------------------------------------------------
    echo -------------------
    echo 'Create git ssh-key'
    ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "git@arthurpieri.com"
    echo -------------------
    #---------------------------------------------------------------------------
    echo -------------------
    echo 'Setting up SSH keys'
    ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519_ssh -C "ssh@arthurpieri.com"
    eval "$(ssh-agent -s)"
    SSH_AGENT=$?
    if [ ${SSH_AGENT} -ne 0 ]
    then
        echo 'Setting ssh passphrase to ssh agent'
        ssh-add ~/.ssh/id_ed25519_ssh
    fi
    echo -------------------

#-------------------------------------------------------------------------------
# Setting Up Aliases
    echo 'Setting Up Atualizar'
    echo "alias atualizar='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'" >> ~/.bashrc
    #---------------------------------------------------------------------------
    alias brc='chmod a+x ~/.bashrc; source ~/.bashrc' 
#-------------------------------------------------------------------------------
# Updating and Upgrading the system
#-------------------------------------------------------------------------------
    f_upgrade
#-------------------------------------------------------------------------------
# Removing initrams
#-------------------------------------------------------------------------------
    sudo apt remove flash-kernel initramfs-tools
#-------------------------------------------------------------------------------
# Fix broken
#-------------------------------------------------------------------------------
    sudo apt --fix-broken install -y
