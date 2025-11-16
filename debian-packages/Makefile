# Makefile By wenjie.zhang
# <wenjie.zhang@seon.com> & <linuxwenjie@gmail.com> 2020/04/

MPATH := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

OUTPUT_FOLDER = $(MPATH)output_deb

HELLO_FOLDER = $(MPATH)hello

PACKAGES = $(OUTPUT_FOLDER)/hello.deb

.PHONY: packages
packages : $(PACKAGES)
	mkdir -p $(OUTPUT_FOLDER)
	sudo chmod 777 *.deb > /dev/null 2>&1 || true
	mv *.deb $(OUTPUT_FOLDER) > /dev/null 2>&1 || true

$(OUTPUT_FOLDER)/hello.deb:
	@dpkg-deb --build $(HELLO_FOLDER)/

all : $(packages) 

hello_clean:
	rm -rf $(HELLO_FOLDER)/sbin/

clean:
	rm -rf $(OUTPUT_FOLDER)
	@make hello_clean
	
fullclean:
	@make clean
