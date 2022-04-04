#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

curl -sSL "https://github.com/alacritty/alacritty/archive/v${VERSION}.tar.gz" -o "${NAME}-${VERSION}.tar.gz"

tar xzf "${NAME}-${VERSION}.tar.gz"

cd "${NAME}-${VERSION}" || exit 1

sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

cargo test 

cargo build --release

# Tests whether the final executable is working or has a build
# error before packaging
"target/release/${NAME}" --version

# Rename files to default system names
mv extra/alacritty.man extra/alacritty.1
mv extra/completions/alacritty.bash extra/completions/alacritty
mv extra/logo/alacritty-term.svg extra/logo/Alacritty.svg

fpm -s dir -t "$PKG_TYPE" --name "$NAME" --version "$VERSION" \
    --architecture "$PKG_ARCH" --license "Apache-2.0" \
    --description "A cross-platform, OpenGL terminal emulator." \
    --deb-no-default-config-files \
    extra/linux/Alacritty.desktop=/usr/share/applications/ \
    extra/alacritty.1=/usr/share/man/man1/ \
    extra/logo/Alacritty.svg=/usr/share/pixmaps/Alacritty.svg \
    extra/completions/alacritty=/usr/share/bash-completion/completions/ \
    "target/release/${NAME}"=/usr/bin/

# Move to default location
mv "${NAME}_${VERSION}_${PKG_ARCH}.deb" ..

