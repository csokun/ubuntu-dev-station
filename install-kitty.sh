#!/bin/bash
sudo su -
apt-get install kitty git -y
exit

git clone --depth 1 git@github.com:dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
rsync -r .config/kitty ~/.config/kitty