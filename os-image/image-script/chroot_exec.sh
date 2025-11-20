#!/bin/bash
set -e

ROOTFS=rootfs
CMD="$*"

[ ! -d "$ROOTFS" ] && echo "NO ROOTFS FOUND" && exit 1

echo "==> Entering CHROOT and RUN:"
echo "    $CMD"

# ----------------------------------------------------
# Cleanup function: always executed (success / fail)
# ----------------------------------------------------
cleanup() {
    echo "[CLEANUP] Unmounting chroot binds..."
    sudo umount -l "$ROOTFS/dev"  2>/dev/null || true
    sudo umount -l "$ROOTFS/proc" 2>/dev/null || true
    sudo umount -l "$ROOTFS/sys"  2>/dev/null || true
    echo "[CLEANUP] Done."
}
trap cleanup EXIT

sudo cp /usr/bin/qemu-arm-static "$ROOTFS/usr/bin/"

sudo mount --bind /dev  "$ROOTFS/dev"
sudo mount --bind /proc "$ROOTFS/proc"
sudo mount --bind /sys  "$ROOTFS/sys"

sudo chroot "$ROOTFS" /bin/bash -c "$CMD"

