#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

cd "$(dirname "$0")"

unset LC_CTYPE
unset LANG

main() {
        mkdir -p build
        cd build
        export META_VERSION=6.1.0-1
        rm -rf linux-image-asahi_${META_VERSION}
        mkdir -p linux-image-asahi_${META_VERSION}/DEBIAN
cat > linux-image-asahi_${META_VERSION}/DEBIAN/control <<EOF
Package: linux-image-asahi
Version: $META_VERSION
Section: base
Depends: linux-image-6.1.0-rc8-asahi (>= 6.1.0-rc8-asahi-36)
Priority: optional
Architecture: arm64
Maintainer: Thomas Glanzmann <thomas@glanzmann.de>
Description: Linux for 64-bit apple silicon machines (meta-package)
EOF
        dpkg-deb --build linux-image-asahi_${META_VERSION}
}

main "$@"
