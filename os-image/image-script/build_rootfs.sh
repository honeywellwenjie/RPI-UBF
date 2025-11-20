#!/bin/bash
set -e

echo "### running rootfs customization ###"

touch /test_wenjie_ok
apt-get update
apt-get install -y vim-tiny htop curl

dpkg -i /*.deb

echo "### build_rootfs.sh finished ###"

