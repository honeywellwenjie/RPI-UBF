#!/bin/bash
set -e

BASE_DIR=$(pwd)
BUILD_DIR=$BASE_DIR/build
MOUNT_BOOT=$BUILD_DIR/mount/boot
MOUNT_ROOT=$BUILD_DIR/mount/rootfs

SRC_IMG=$1
TMP_IMG=$BUILD_DIR/rpi_edit.img

QEMU="sudo proot -q qemu-arm -S ${MOUNT_ROOT} \
      -b ${MOUNT_BOOT}:/boot \
      -b ${MOUNT_ROOT}:/realroot"

cleanup() {
    sync || true
    sudo umount $MOUNT_BOOT 2>/dev/null || true
    sudo umount $MOUNT_ROOT 2>/dev/null || true
    sudo losetup -d "$LOOPDEV" 2>/dev/null || true
    echo "[OK] Cleanup done"
}
trap cleanup EXIT

[ -z "$SRC_IMG" ] && echo "Usage: $0 image.img" && exit 1

rm -rf "$BUILD_DIR"
mkdir -p "$MOUNT_BOOT" "$MOUNT_ROOT"

cp "$SRC_IMG" "$TMP_IMG"

LOOPDEV=$(sudo losetup -f --show -P "$TMP_IMG")

[ ! -e "${LOOPDEV}p2" ] && echo "No root partition detected" && exit 1

sudo mount ${LOOPDEV}p1 "$MOUNT_BOOT"
sudo mount ${LOOPDEV}p2 "$MOUNT_ROOT"

shift
while [ "$1" != "" ]; do
    case "$1" in
        -overlay)
            echo "Copy overlay → /"
            sudo rsync -a "$2"/ "$MOUNT_ROOT"/
            shift 2
            ;;
        -bash)
            echo "Running inside QEMU: $2"
            ${QEMU} /bin/bash -c "$2"
            shift 2
            ;;
        -rm)
            [[ "$2" == "/" ]] && echo "REFUSE delete root" && exit 1
            sudo rm -rf "$MOUNT_ROOT$2"
            shift 2
            ;;
    esac
done

echo "Done. Modified image → $TMP_IMG"

