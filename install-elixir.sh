#!/bin/bash
ASDF=$(which asdf)
if [ -z "$ASDF" ]; then
    echo "Install asdf"
    ./install-asdf.sh
fi

# install erlang
sudo apt-get -y install build-essential \
    autoconf \
    m4 \
    libncurses5-dev \
    libwxgtk3.0-gtk3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libpng-dev \
    libssh-dev \
    unixodbc-dev \
    xsltproc \
    fop \
    libxml2-utils \
    libncurses-dev \
    openjdk-11-jdk

asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

cat >> ~/.tool-versions <<EOL
erlang 23.2
elixir 1.11.3-otp-23
EOL

asdf install