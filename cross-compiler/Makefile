IMAGE_NAME = rpibuild

all: build

build:
	docker build --platform=linux/arm/v7 -t $(IMAGE_NAME) -f Dockerfile .

clean:
	@echo "Cleaning unused build layers..."
	- docker image prune -f

fullclean: clean
	@echo "Removing Docker image: $(IMAGE_NAME)"
	- docker rmi $(IMAGE_NAME)
