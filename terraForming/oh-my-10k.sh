#!/bin/bash

sudo apt install -y zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

source ~/.zshrc

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Install ruby
sudo apt install ruby-full

# install colorsls
sudo gem install colorls

# Configurando o p10k
p10k configure

# activate the plugins
sed -i 's/plugins=(git)/plugins=(asdf docker npm node vscode git zsh-autosuggestions zsh-syntax-highlighting zsh-navigation-tools safe-paste python )/g' ~/.zshrc
