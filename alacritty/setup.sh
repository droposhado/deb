#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable --profile minimal

curl -sSL "https://github.com/alacritty/alacritty/archive/refs/tags/v${VERSION}.tar.gz" \
     -o "${NAME}-${VERSION}.tar.gz"

tar xzvf "${NAME}-${VERSION}.tar.gz"

cd "${NAME}-${VERSION}" || exit 1

sudo apt-get install -y --no-install-recommends cmake pkg-config libfreetype6-dev \
     libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

cargo test --release --verbose

cargo build --release --verbose

# Tests whether the final executable is working or has a build
# error before packaging
"target/release/${NAME}" --version

# Rename files to default system names
mv extra/alacritty.man extra/alacritty.1
mv extra/completions/alacritty.bash extra/completions/alacritty
mv extra/logo/alacritty-term.svg extra/logo/Alacritty.svg

fpm -s dir -t "deb" --name "$NAME" --version "$VERSION" \
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

