#!/bin/bash
set -e

ROOTFS=rootfs
CMD="$*"

[ ! -d "$ROOTFS" ] && echo "NO ROOTFS FOUND" && exit 1

echo "==> Entering CHROOT and RUN:"
echo "    $CMD"

sudo cp /usr/bin/qemu-arm-static "$ROOTFS/usr/bin/"

sudo mount --bind /dev  "$ROOTFS/dev"
sudo mount --bind /proc "$ROOTFS/proc"
sudo mount --bind /sys  "$ROOTFS/sys"

sudo chroot "$ROOTFS" /bin/bash -c "$CMD"

sudo umount "$ROOTFS/dev"
sudo umount "$ROOTFS/proc"
sudo umount "$ROOTFS/sys"

