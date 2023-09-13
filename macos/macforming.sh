#! /bin/bash
#
# /HEADER/
# Vm Forming Script
# This script is currently on v2
# Author: Arthur Pieri
#
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install pre-requisites to asdf
brew install coreutils curl git

# install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.0
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bash_profile
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bash_profile

# install asdf plugins
asdf plugin add nodejs
asdf plugin add python
asdf plugin add golang
asdf plugin add rust

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install golang
asdf install golang latest
asdf global golang latest

# install python
asdf install python latest
asdf global python latest

# install nodejs
asdf install nodejs latest
asdf global nodejs latest

# install bat
brew install bat

# install exa
brew install exa

# install fd
brew install fd

# install procs
brew install procs

# install riggrep
brew install ripgrep

# install tokei
brew install tokei

# install bottom
brew install bottom

# install grex
brew install grex

