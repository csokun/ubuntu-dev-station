#!/bin/bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

cat >> ~/.bashrc <<EOL
# asdf config
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
EOL

source ~/.bashrc