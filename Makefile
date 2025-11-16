SUBDIRS = \
	cross-compiler \
	src-code \
	debian-packages \
	os-image

SUBDIRS_C = \
	os-image	\
	debian-packages \
	src-code \
	cross-compiler

.PHONY: all clean fullclean $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

clean fullclean: $(SUBDIRS_C)

