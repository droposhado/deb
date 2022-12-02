#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

git clone https://github.com/nullgemm/ly.git "${NAME}-${VERSION}" --branch "v${VERSION}" --single-branch

cd "${NAME}-${VERSION}" || exit 1

sudo apt-get update
sudo apt-get install build-essential libpam0g-dev libxcb-xkb-dev

# SUBMODULE upstream versions already fixed this

if [ ! -f sub/argoat/.gitmodules ]; then


git submodule sync
git submodule update --init --remote
cd sub/argoat

echo "[submodule \"sub/testoasterror\"]
	path = sub/testoasterror
	url = https://github.com/nullgemm/testoasterror.git" > .gitmodules
fi

git submodule update --init --remote
cd -

# SUBMODULE end

make

chmod 644 res/ly.service
chmod 644 res/pam.d/ly

fpm -s dir -t "deb" --name "$NAME" --version "$VERSION" \
    --architecture "$PKG_ARCH" --license "WTFPL" \
    --description "display manager with console UI" \
    res/config.ini=/etc/ly/config.ini \
    res/xsetup.sh=/etc/ly/xsetup.sh \
    res/wsetup.sh=/etc/ly/wsetup.sh \
    res/lang/=/etc/ly/lang/ \
    res/ly.service=/usr/lib/systemd/system/ly.service \
    res/pam.d/ly=/etc/pam.d/ly \
    bin/"$NAME"=/usr/bin/"$NAME"

# Move to default location
mv "${NAME}_${VERSION}_${PKG_ARCH}.deb" ..
