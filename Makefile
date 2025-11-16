SUBDIRS = \
	cross-compiler \
	src-code \
	debian-packages

SUBDIRS_C = \
	debian-packages \
	src-code \
	cross-compiler

.PHONY: all clean fullclean $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

clean fullclean: $(SUBDIRS_C)

