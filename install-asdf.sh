#!/bin/bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

cat >> ~/.bashrc <<EOL
# asdf config
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
EOL

cat >> ~/.tool-versions <<EOL
erlang 23.2
elixir 1.11.3-otp-23
nodejs 12.19.0
rust 1.48.0
EOL

source ~/.bashrc
