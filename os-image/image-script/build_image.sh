#!/bin/bash
set -e

PROJECT_ROOT=$(realpath "$(dirname "$0")/../..")

IMAGE_DIR="${PROJECT_ROOT}/os-image/cache"
BASE_IMAGE="${IMAGE_DIR}/2025-10-01-raspios-trixie-armhf-lite.img"

TOOLS="${PROJECT_ROOT}/build-tools/vm_img.sh"
DEB_PKGS="${PROJECT_ROOT}/debian-packages/output_deb/*"

# Basic checks
[ ! -f "$BASE_IMAGE" ] && echo "IMAGE NOT FOUND: $BASE_IMAGE" && exit 1
[ ! -x "$TOOLS" ] && echo "vm_img.sh NOT executable: $TOOLS" && exit 1

echo "Using image: $BASE_IMAGE"
echo "Using tool:  $TOOLS"

sudo "$TOOLS" "$BASE_IMAGE" \
    -bash 'mkdir -p /mnt' \
    -c "$DEB_PKGS" "/mnt" \
    -bash 'ls -l /mnt' \
    -bash 'APT_CONFIG=/dev/null apt-get update --allow-insecure-repositories || true' \
    -bash 'apt-get install -y vim-tiny --allow-unauthenticated || true' \
    -bash 'dpkg -i /mnt/*.deb || true' \
    -bash 'echo DONE'

echo "IMAGE BUILD DONE"

