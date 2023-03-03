SUBDIRS := debian ubuntu archlinux manjaro fedora alpine

DOCKER := docker

VERSION := 1.0.0

.PHONY: all clean test $(SUBDIRS)

clean: $(SUBDIRS)
	$(MAKE) -C $@ clean

$(SUBDIRS):
	$(MAKE) -C $@ test VERSION="$(VERSION)"

test: $(SUBDIRS)
	$(MAKE) -C $@ test

.SECONDEXPANSION:
$(addsuffix .test,$(SUBDIRS)): $$(basename $$@)
	$(MAKE) -C $(basename $@) test

push: $(SUBDIRS)
	$(MAKE) -C $@ push
