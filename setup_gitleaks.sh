#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

curl -sSL "https://github.com/zricethezav/gitleaks/releases/download/v${VERSION}/gitleaks-${VERSION}-linux_x64.tar.gz" -o "${NAME}-${VERSION}.tar.gz"

tar xzf "${NAME}-${VERSION}.tar.gz"

chmod +x "${NAME}"

fpm -s dir -t "$PKG_TYPE" --name "$NAME" --version "$VERSION" \
     --architecture "$PKG_ARCH" --license "MIT" \
     --description "Scan git repos (or files) for secrets using regex and entropy" \
    "${NAME}"=/usr/bin/
