#!/bin/bash
set -e

IMG="$1"

[ ! -f "$IMG" ] && echo "IMAGE NOT FOUND" && exit 1

BASE_DIR=$(pwd)
ROOTFS=rootfs
BUILD=build

echo "==> Extracting rootfs from $IMG"

rm -rf "$BUILD" "$ROOTFS"
mkdir -p "$BUILD"

LOOP=$(sudo losetup -f --show -P "$IMG")
sudo mount ${LOOP}p2 "$BUILD"

mkdir -p "$ROOTFS"
sudo rsync -a "$BUILD"/ "$ROOTFS"/

sudo umount "$BUILD"
sudo losetup -d "$LOOP"

echo "[OK] ROOTFS extracted to: $ROOTFS"

