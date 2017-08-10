NAMESPACE = ypcs/debian

SUITES = jessie stretch sid
DEBIAN_MIRROR = http://deb.debian.org/debian

SUDO = /usr/bin/sudo
DEBOOTSTRAP = /usr/sbin/debootstrap
DEBOOTSTRAP_FLAGS = --variant=minbase
TAR = /bin/tar

all: clean $(SUITES)

clean:
	rm -rf *.tar chroot-*

$(SUITES): % : %.tar

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
