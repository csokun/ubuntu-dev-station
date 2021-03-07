#!/bin/bash
ASDF=$(which asdf)
if [ -z "$ASDF" ]; then
    echo "Install asdf"
    ./install-asdf.sh
fi

asdf plugin-add rust https://github.com/code-lever/asdf-rust.git

cat >> ~/.tool-versions <<EOL
rust 1.48.0
EOL

asdf install