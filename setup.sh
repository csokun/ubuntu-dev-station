#!/bin/bash
# Pre-requisites:
# ----------------------------------------------
# setup development environment (Ubuntu)
set -e

# prefer package version
export NODE_VERSION=12.16.1
export TOR_BROWSER_VERSION=9.0.5

# change priviledge
sudo su -
# snap! cool, but I'm not a fan.
apt-get remove --purge gnome-software-plugin-snap
apt update && apt install -y curl \
  jq \
  ffmpeg \
  xsel \
  bash-completion \
  git \
  tmux \
  calibre \
  meld \
  gitk \
  apt-transport-https \
  gnupg-agent \
  ca-certificates \
  gnome-tweak-tool \
  software-properties-common

# youtube-dl
curl -sL https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

# neovim
curl -sL https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -o nvim-linux64.tar.gz 
tar -xf nvim-linux64.tar.gz
cp -a nvim-linux64/* /usr/local/
ln -s /usr/local/bin/nvim /usr/local/bin/vim
rm -rf nvim-linux64
rm nvim-linux64.tar.gz
exit

# install powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts && ./install.sh && cd ..
rm -rf fonts

# tmux config
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
wget https://raw.githubusercontent.com/csokun/ubuntu-dev-station/master/.tmux.conf

# vim config
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
wget https://raw.githubusercontent.com/csokun/ubuntu-dev-station/master/.vimrc

# install nvm - Node Version Manager
NODE_NVM_VERSION=$(curl -sL "https://api.github.com/repos/creationix/nvm/tags" | jq ".[0].name" | sed 's/\"//g')
wget -qO- https://raw.githubusercontent.com/creationix/nvm/${NODE_NVM_VERSION}/install.sh | bash
source ~/.bashrc
sleep 2s && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION

# docker
sudo su -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update  && apt install docker-ce docker-ce-cli containerd.io
# run docker without sudo
chown $USER:docker /var/run/docker.sock
usermod -aG docker $USER
# start docker on boot
systemctl enable docker

DOCKER_COMPOSE_VERSION=$(curl -sL "https://api.github.com/repos/docker/compose/releases" | jq ".[0].name" | sed 's/\"//g')
curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
exit

# git credential - remember for 24hr
wget https://raw.githubusercontent.com/wmanley/git-meld/master/git-meld.pl -qO ~/.git-meld.pl

git config credential.helper
git config --global credential.helper "cache --timeout=86400"
# git logline (ref. https://ma.ttias.be/pretty-git-log-in-one-line/)
git config --global alias.logline "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# tor-browser
TOR_BROWSER="tor-browser-linux64-${TOR_BROWSER_VERSION}_en-US.tar.xz"
wget "https://dist.torproject.org/torbrowser/${TOR_BROWSER_VERSION}/${TOR_BROWSER}" -qO $TOR_BROWSER
mkdir -p $HOME/tor-browser
tar -xJf $TOR_BROWSER -C $HOME/tor-browser
rm $TOR_BROWSER
cat >> ~/.bashrc <<EOL
# tor-browser
alias tb='echo "http://uj3wazyk5u4hnvtk.onion/" | xsel --clipboard && $HOME/tor-browser/Browser/start-tor-browser --detach'
EOL

# setup prompt
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -qO ~/.git-prompt.sh

cat >> ~/.bashrc <<EOL
# git-prompt
source ~/.git-prompt.sh
PS1='\[\e[32m\]\u\[\e[m\]\[\e[35m\]@\h\[\e[m\]:\w\$(__git_ps1 " (%s)")\n \$ '

# setup Elixir aliases
export ELIXIR_IMAGE="csokun/elixir-studio:latest"
export ELIXIR_HOST_ROOT="$HOME/elixir"
if [ ! -d "$ELIXIR_HOST_ROOT" ]; then
    mkdir -p $ELIXIR_HOST_ROOT/.mix $ELIXIR_HOST_ROOT/.hex
fi
export ELIXIR_CONTAINER_ROOT="/home/elixir"
export ELIXIR_VOLUMES="-v ${ELIXIR_HOST_ROOT}/.mix:${ELIXIR_CONTAINER_ROOT}/.mix -v ${ELIXIR_HOST_ROOT}/.hex:${ELIXIR_CONTAINER_ROOT}/.hex --mount type=bind,source=${HOME}/.gitconfig,target=${ELIXIR_CONTAINER_ROOT}/.gitconfig,readonly --workdir /src"

alias iex='docker run -it ${ELIXIR_VOLUMES} -e DISPLAY=$DISPLAY -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE}'
alias iexm='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} iex -S mix'
alias elixir='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} elixir'
alias elixirc='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} elixirc'
alias mix='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} mix'
alias iexstudio='docker run -it ${ELIXIR_VOLUMES} -e DISPLAY=$DISPLAY -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} studio'
alias elc='echo "removing .mix and .hex directories" && rm -rf ${ELIXIRROOT}/.mix && rm -rf ${ELIXIRROOT}/.hex'
EOL

source ~/.bashrc

# terminal theme
read -p "Create a dummy profile for gnome terminal and Press enter to continue"
wget -O gogh https://git.io/vQgMr && chmod +x gogh && ./gogh
