.PHONY: all clean fullclean

CACHE_DIR = cache
IMG_SCRIPT = image-script

all:
	$(OS_SCRIPT)/download_images.sh
	$(OS_SCRIPT)/prepare_image.sh

clean:
	echo "os-image clean"

fullclean:
	echo "Removing cache directory..."
	rm -rf $(CACHE_DIR)

