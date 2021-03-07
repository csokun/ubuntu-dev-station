#!/bin/bash
GOPATH=$(which go)
if [ -n "$GOPATH" ]; then
    echo "Go installed: $GOPATH"
    go version
    exit 1
fi

VERSION=1.16
PKG_NAME="go${VERSION}.linux-amd64.tar.gz"
URL="https://golang.org/dl/${PKG_NAME}"

echo "Download golang $URL"
curl -sL $URL -o /tmp/$PKG_NAME

echo "Install golang $VERSION"
cd /tmp
sudo tar -C /usr/local -xzf $PKG_NAME
rm /tmp/$PKG_NAME

if ! grep -q /usr/local/go/bin ~/.profile; then
    echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
    source ~/.profile
fi

go version
