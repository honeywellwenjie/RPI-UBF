#!/bin/bash
set -e

IMG="$1"

[ ! -f "$IMG" ] && echo "IMAGE NOT FOUND" && exit 1

BASE_DIR=$(pwd)
ROOTFS=rootfs
MOUNT_POINT=tmp

echo "==> Extracting rootfs from $IMG"

rm -rf "$MOUNT_POINT" "$ROOTFS"
mkdir -p "$MOUNT_POINT"

LOOP=$(sudo losetup -f --show -P "$IMG")
sudo mount ${LOOP}p2 "$MOUNT_POINT"

mkdir -p "$ROOTFS"
sudo rsync -a "$MOUNT_POINT"/ "$ROOTFS"/

sudo umount "$MOUNT_POINT"
sudo losetup -d "$LOOP"

rm -rf "$MOUNT_POINT"
echo "[OK] ROOTFS extracted to: $ROOTFS"

