#!/bin/bash
set -e

ROOTFS="$1"
shift
CMD="$*"

[ -z "$ROOTFS" ] && echo "ERROR: Missing ROOTFS path" && exit 1
[ ! -d "$ROOTFS" ] && echo "ERROR: ROOTFS does not exist: $ROOTFS" && exit 1
[ -z "$CMD" ] && echo "ERROR: No command specified" && exit 1

echo "==> Entering CHROOT:"
echo "    ROOTFS = $ROOTFS"
echo "    CMD    = $CMD"

# ===============================
# Cleanup (always executed)
# ===============================
cleanup() {
    echo "[CLEANUP] Unmounting chroot binds..."
    sudo umount -l "$ROOTFS/dev"  2>/dev/null || true
    sudo umount -l "$ROOTFS/proc" 2>/dev/null || true
    sudo umount -l "$ROOTFS/sys"  2>/dev/null || true
    echo "[CLEANUP] Done."
}
trap cleanup EXIT

sudo cp /usr/bin/qemu-arm-static "$ROOTFS/usr/bin/" 2>/dev/null || true

sudo mount --bind /dev  "$ROOTFS/dev"
sudo mount --bind /proc "$ROOTFS/proc"
sudo mount --bind /sys  "$ROOTFS/sys"

sudo chroot "$ROOTFS" /bin/bash -c "$CMD"

