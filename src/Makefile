SUBDIRS = \
	test

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean: $(SUBDIRS:%=%-clean)

%-clean:
	$(MAKE) -C $(patsubst %-clean,%,$@) clean
