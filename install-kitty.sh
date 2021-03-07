#!/bin/bash
sudo su -
apt-get install kitty git fonts-firacode -y
exit

mkdir -p ~/.config/kitty
git clone --depth 1 git@github.com:dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
rsync -r .config/kitty ~/.config/kitty