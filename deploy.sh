#!/bin/bash

curl -F package=@"${NAME}_${VERSION}_${PKG_ARCH}.deb" \
   "https://${FURY_TOKEN}@push.fury.io/${FURY_USERNAME}/"

