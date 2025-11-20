all: .image.sentinel

.PHONY: all clean fullclean

CACHE_DIR = cache
IMG_SCRIPT = image-script
IMG_NAME = 2025-10-01-raspios-trixie-armhf-lite.img
ROOTFS_FOLDER = rootfs
OUTPUT_FOLDER = ./../output
OUTPUT_IMG = rpi-build.img

.image.sentinel: .download.sentinel .rootfs.sentinel .build.sentinel .pack.sentinel
	echo "building os-image"
	touch $@

.download.sentinel:
	$(IMG_SCRIPT)/download_images.sh
	touch $@

.rootfs.sentinel: .download.sentinel
	$(IMG_SCRIPT)/prepare_image.sh
	sudo $(IMG_SCRIPT)/unpack_rootfs.sh $(CACHE_DIR)/$(IMG_NAME)
	sudo cp $(IMG_SCRIPT)/build_rootfs.sh $(ROOTFS_FOLDER)/
	touch $@

.build.sentinel: .rootfs.sentinel
	sudo $(IMG_SCRIPT)/chroot_exec.sh $(ROOTFS_FOLDER) /build_rootfs.sh
	sudo rm -rf $(ROOTFS_FOLDER)/build_rootfs.sh
	touch $@

.pack.sentinel: .build.sentinel
	sudo $(IMG_SCRIPT)/pack_rootfs.sh $(CACHE_DIR)/$(IMG_NAME)
	mkdir -p $(OUTPUT_FOLDER)
	mv $(CACHE_DIR)/$(IMG_NAME) $(OUTPUT_FOLDER)/$(OUTPUT_IMG)
	touch $@

clean:
	echo "os-image clean"
	@sudo rm -rf rootfs
	rm -rf $(OUTPUT_FOLDER)
	rm -rf .image.sentinel
	rm -rf .build.sentinel
	rm -rf .pack.sentinel
	rm -rf .rootfs.sentinel

fullclean:
	echo "Removing cache directory..."
	@make clean
	rm -rf $(CACHE_DIR)
	rm -rf .download.sentinel

