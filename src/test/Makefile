IMAGE_NAME   = rpibuild

# Detect project root (directory containing this test dir)
PROJECT_ROOT := $(realpath $(CURDIR)/..)

SRC    = hello.c
TARGET = hello

all: build

build:
	docker run --platform=linux/arm/v7 --rm \
		-v $(PROJECT_ROOT):/work \
		$(IMAGE_NAME) \
		sh -c "cd /work/test && gcc $(SRC) -o $(TARGET)"

clean:
	rm -f $(TARGET)

rebuild: clean build

