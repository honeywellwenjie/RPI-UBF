#!/bin/bash
set -e

CACHE_DIR="./cache"

IMG_XZ=$(ls ${CACHE_DIR}/*.img.xz 2>/dev/null | head -n 1)

if [ -z "$IMG_XZ" ]; then
    echo "No .img.xz found in cache/"
    echo "Run:  make   (to download image)"
    exit 1
fi

IMG_FILE="${IMG_XZ%.xz}"

echo "Found compressed image:"
echo "  $IMG_XZ"
echo

if [[ -f "$IMG_FILE" ]]; then
    echo "Image already extracted:"
    echo "  $IMG_FILE"
else
    echo "Extracting image..."
    xz -dk "$IMG_XZ"
fi

echo "Done"

