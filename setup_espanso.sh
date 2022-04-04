#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# curl -sSL "https://github.com/federico-terzi/espanso/releases/download/v${VERSION}/espanso-linux-sha256.txt" -o "${NAME}.txt"

# curl -sSL "https://github.com/federico-terzi/espanso/releases/download/v${VERSION}/espanso-linux.tar.gz" -o "${NAME}-linux.tar.gz"

# sha256sum -c "${NAME}.txt"

# tar xzf "${NAME}-linux.tar.gz"

# chmod +x "$NAME"

# fpm -s dir -t "$PKG_TYPE" --name "$NAME" --version "$VERSION" \
#     --architecture  "$PKG_ARCH" --license "GPL-3.0" \
#     --description "Cross-platform Text Expander written in Rust" \
#     -d "libxdmcp6 >= 1:1.1.2" -d "libxkbcommon0 >= 0.8.2" -d "libc6 >= 2.27" \
    # -d "libbsd0 >= 0.8.7" -d "libxext6 >= 2:1.3.3" -d "libxcb1 >= 1.13" \
    # -d "libx11-6 >= 2:1.6.4" -d "libxdo3" -d "libssl1.1 >= 1.1.1" \
    # -d "libxdo3 >= 1:3.20160805.1" -d "libxtst6 >= 2:1.2.3" -d "xclip" \
    # -d "libxinerama1 >= 2:1.1.3" -d "libxau6 >= 1:1.0.8" -d "libxtst6" \
    # -d "libnotify-bin" "$NAME"=/usr/bin/

# Espanso already provides the package, it just does not name the final
# package as standard and has no APT compatible repository. Here it is just
# renamed, since what the total packaging process entails is dependency
# management that is already done in the downloaded package.
curl -sSL "https://github.com/federico-terzi/espanso/releases/download/v${VERSION}/espanso-debian-amd64.deb" -o "${NAME}_${VERSION}_${PKG_ARCH}.deb"
