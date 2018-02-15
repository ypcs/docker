NAMESPACE = ypcs/debian

DEBIAN_SUITES = jessie stretch buster sid
DEBIAN_MIRROR ?= http://deb.debian.org/debian

SUDO = /usr/bin/sudo
DEBOOTSTRAP = /usr/sbin/debootstrap
DEBOOTSTRAP_FLAGS = --variant=minbase
TAR = /bin/tar

all: clean $(DEBIAN_SUITES)

push:
	docker push $(NAMESPACE)

clean:
	rm -rf *.tar chroot-*

$(DEBIAN_SUITES): % : %.tar

%.tar: chroot-%
	$(TAR) -C $< -c . -f $@

chroot-%:
	$(DEBOOTSTRAP) $(DEBOOTSTRAP_FLAGS) $* $@ $(DEBIAN_MIRROR)
	cp setup.sh $@/tmp/setup.sh
	chmod +x $@/tmp/setup.sh
	chroot $@ /tmp/setup.sh $* $(DEBIAN_MIRROR)
	rm -f $@/tmp/setup.sh

import-%: %.tar
	docker import - $(NAMESPACE):$* < $<

images:
	$(MAKE) -C $@

.PHONY: images
