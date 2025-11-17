#!/bin/bash
set -e

IMG="$1"
ROOTFS=rootfs
MOUNT_POINT=tmp

[ ! -d "$ROOTFS" ] && echo "NO ROOTFS FOUND" && exit 1
[ ! -f "$IMG" ] && echo "IMAGE NOT FOUND" && exit 1

echo "Attaching image..."
LOOP=$(sudo losetup -f --show -P "$IMG")

mkdir -p "$MOUNT_POINT"
sudo mount ${LOOP}p2 "$MOUNT_POINT"

echo "Syncing rootfs (SAFE MODE)..."
sudo rsync -aHAX --ignore-existing "$ROOTFS"/ "$MOUNT_POINT"/

echo "Flushing disk cache..."
sync

echo "Unmounting..."
sudo umount "$MOUNT_POINT"
sudo losetup -d "$LOOP"
rm -rf "$MOUNT_POINT"

echo "ROOTFS PACKED → $IMG"

