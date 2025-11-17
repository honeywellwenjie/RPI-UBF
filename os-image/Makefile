.PHONY: all clean fullclean

CACHE_DIR = cache
OS_HANDLE_SCRIPT = image-pipeline

all:
	$(OS_HANDLE_SCRIPT)/download_images.sh
	$(OS_HANDLE_SCRIPT)/prepare_image.sh

clean:
	echo "os-image clean"

fullclean:
	echo "Removing cache directory..."
	rm -rf $(CACHE_DIR)

