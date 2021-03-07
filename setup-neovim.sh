#!/bin/bash
# neovim
curl -sL https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -o nvim-linux64.tar.gz 
tar -xf nvim-linux64.tar.gz
cp -a nvim-linux64/* /usr/local/
ln -s /usr/local/bin/nvim /usr/local/bin/vim
rm -rf nvim-linux64
rm nvim-linux64.tar.gz

# install plug
mkdir -p ~/.config/nvim/autoload
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo su -
apt-get update && apt-get install fzf git ripgrep silversearcher-ag -y

# lazygit
add-apt-repository ppa:lazygit-team/release
apt-get update && apt-get install lazygit -y
exit

# copy custom config
rsync -r .config/nvim ~/.config/nvim
