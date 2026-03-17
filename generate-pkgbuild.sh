#!/bin/bash
set -euo pipefail

VERSION="${1:?Usage: $0 <version> [branch]}"
BRANCH="${2:-release}"

BASE_URL="https://releases.epilogue.co/desktop/playback/${VERSION}/${BRANCH}/linux"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Fetching checksums for Playback ${VERSION} (${BRANCH})..."

SHA512_AMD64=$(curl -sf "${BASE_URL}/sha512sum-amd64.txt") || {
  echo "Error: Could not fetch amd64 checksum from ${BASE_URL}/sha512sum-amd64.txt"
  exit 1
}

SHA512_ARM64=$(curl -sf "${BASE_URL}/sha512sum-arm64.txt") || {
  echo "Error: Could not fetch arm64 checksum from ${BASE_URL}/sha512sum-arm64.txt"
  exit 1
}

SHA512_PLAYBACK_SH=$(sha512sum playback.sh | awk '{print $1}')
SHA512_UDEV_RULES=$(sha512sum 60-gb-operator.rules | awk '{print $1}')

sed -e "s/__PKGVER__/${VERSION}/g" \
    -e "s/__BRANCH__/${BRANCH}/g" \
    -e "s/__SHA512SUM_APPIMAGE_AMD64__/${SHA512_AMD64}/g" \
    -e "s/__SHA512SUM_APPIMAGE_ARM64__/${SHA512_ARM64}/g" \
    -e "s/__SHA512SUM_PLAYBACK_SH__/${SHA512_PLAYBACK_SH}/g" \
    -e "s/__SHA512SUM_UDEV_RULES__/${SHA512_UDEV_RULES}/g" \
    PKGBUILD.template > PKGBUILD

echo "Generated PKGBUILD for playback-appimage ${VERSION} (${BRANCH})"
