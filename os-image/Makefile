all: .image.sentinel

.PHONY: all clean fullclean

CACHE_DIR = cache
IMG_SCRIPT = image-script
IMG_NAME = 2025-10-01-raspios-trixie-armhf-lite.img

.image.sentinel: .download.sentinel .rootfs.sentinel .package.sentinel
	echo "building os-image"
	touch $@

.download.sentinel:
	$(IMG_SCRIPT)/download_images.sh
	touch $@

.rootfs.sentinel: .download.sentinel
	$(IMG_SCRIPT)/prepare_image.sh
	sudo $(IMG_SCRIPT)/unpack_rootfs.sh $(CACHE_DIR)/$(IMG_NAME)
	touch $@

.package.sentinel: .rootfs.sentinel
	touch $@


clean:
	echo "os-image clean"
	@sudo rm -rf rootfs
	rm -rf .image.sentinel
	rm -rf .package.sentinel
	rm -rf .rootfs.sentinel

fullclean:
	echo "Removing cache directory..."
	@make clean
	rm -rf $(CACHE_DIR)
	rm -rf .download.sentinel

