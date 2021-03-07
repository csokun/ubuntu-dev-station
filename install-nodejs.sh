#!/bin/bash
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

cat >> ~/.tool-versions <<EOL
nodejs 12.19.0
EOL

asdf install