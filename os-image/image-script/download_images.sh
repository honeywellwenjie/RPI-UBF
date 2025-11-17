#!/bin/bash
set -e

CACHE_DIR="./cache"

IMG_URL="https://downloads.raspberrypi.com/raspios_lite_armhf/images/raspios_lite_armhf-2025-10-02/2025-10-01-raspios-trixie-armhf-lite.img.xz"
SHA_URL="${IMG_URL}.sha256"

IMG_FILE="${CACHE_DIR}/$(basename ${IMG_URL})"
SHA_FILE="${IMG_FILE}.sha256"

mkdir -p "$CACHE_DIR"

echo "Cache directory: $CACHE_DIR"
echo

echo "Downloading SHA256 checksum..."
wget -q -O "${SHA_FILE}" "${SHA_URL}"

EXPECTED_SHA=$(cut -d' ' -f1 "${SHA_FILE}")

echo "Expected SHA256: ${EXPECTED_SHA}"
echo

if [[ -f "${IMG_FILE}" ]]; then
    echo "Existing image found: ${IMG_FILE}"

    REAL_SHA=$(sha256sum "${IMG_FILE}" | cut -d' ' -f1)
    echo "Current SHA256: ${REAL_SHA}"

    if [[ "${REAL_SHA}" == "${EXPECTED_SHA}" ]]; then
        echo "Checksum OK. No download required."
        exit 0
    else
        echo "Checksum mismatch. Removing file."
        rm -f "${IMG_FILE}"
    fi
fi

echo "Downloading image..."
wget -O "${IMG_FILE}" "${IMG_URL}"

echo "Verifying checksum..."
REAL_SHA=$(sha256sum "${IMG_FILE}" | cut -d' ' -f1)

if [[ "${REAL_SHA}" != "${EXPECTED_SHA}" ]]; then
    echo "Checksum failed. Removing file."
    rm -f "${IMG_FILE}"
    exit 1
fi

echo "Download complete and verified."

