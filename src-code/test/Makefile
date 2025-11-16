IMAGE_NAME   = rpibuild

PROJECT_ROOT := $(CURDIR)
DEB_ROOT := $(PROJECT_ROOT)/../../debian-packages/hello/sbin

SRC    = hello.c
TARGET = hello

all: build install

build:
	docker run --platform=linux/arm/v7 --rm \
		-v $(PROJECT_ROOT):/work \
		$(IMAGE_NAME) \
		sh -c "cd /work && gcc $(SRC) -o $(TARGET)"

install:
	mkdir -p $(DEB_ROOT)
	cp $(PROJECT_ROOT)/$(TARGET) $(DEB_ROOT)/

clean:
	rm -rf $(PROJECT_ROOT)/$(TARGET)

rebuild: clean build

