#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

curl -sSL "https://github.com/greshake/i3status-rust/archive/refs/tags/v${VERSION}.tar.gz" -o "${NAME}-${VERSION}.tar.gz"

tar xzf "${NAME}-${VERSION}.tar.gz"

# Extraction create i3status-rust-$VERSION folder, but needs be "${NAME}-${VERSION}"
# This command normalize

if [[ ! -d "${NAME}-${VERSION}" ]]; then
  mkdir "${NAME}-${VERSION}"
fi


tar xzf "${NAME}-${VERSION}.tar.gz" -C "${NAME}-${VERSION}" --strip-components 1

cd "${NAME}-${VERSION}" || exit 1

sudo apt-get install -y --no-install-recommends build-essential libssl-dev \
    libdbus-1-dev libnotmuch-dev libpulse-dev libgoogle-perftools-dev \
    libsensors-dev libssl-dev --no-install-recommends

cargo test --all-features --all-targets --verbose

cargo build --release --all-targets --verbose

# Tests whether the final executable is working or has a build
# error before packaging
# Target needs be manual, because use rs and not rust on name
target/release/i3status-rs --version

fpm -s dir -t "deb" --name "$NAME" --version "$VERSION" \
    --architecture "$PKG_ARCH" --license "GPL-3.0" \
    --description "Very resourcefriendly and feature-rich replacement for i3status, written in pure Rust" \
    -d "libnotmuch5" -d "libsensors5" -d "libgoogle-perftools4" \
    --deb-no-default-config-files \
    files/=/usr/share/i3status-rust/ \
    target/release/i3status-rs=/usr/bin/i3status-rs

# Move to default location
mv "${NAME}_${VERSION}_${PKG_ARCH}.deb" ..
