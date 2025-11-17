#!/bin/bash
set -e

IMG="$1"
ROOTFS=rootfs

[ ! -d "$ROOTFS" ] && echo "NO ROOTFS FOUND" && exit 1
[ ! -f "$IMG" ] && echo "IMAGE NOT FOUND" && exit 1

LOOP=$(sudo losetup -f --show -P "$IMG")

sudo mount ${LOOP}p2 /mnt
sudo rsync -a "$ROOTFS"/ /mnt/
sync

sudo umount /mnt
sudo losetup -d "$LOOP"

echo "[OK] ROOTFS written back → $IMG"

