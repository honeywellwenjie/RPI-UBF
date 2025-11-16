
SUBDIRS = \
	cross-compiler 	\
	src		

SUBDIRS_C = \
	src		\
	cross-compiler

.PHONY: subdirs $(SUBDIRS)

all:  subdirs

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

clean fullclean: $(SUBDIRS_C)

