SUBDIRS = \
	test

SUBDIRS_C = \
	test

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

clean fullclean: $(SUBDIRS_C)
