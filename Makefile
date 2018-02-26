NAMESPACE = ypcs

APT_PROXY ?=

DEBIAN_SUITES = jessie stretch buster sid
DEBIAN_MIRROR ?= http://$(patsubst http://%,%,$(APT_PROXY))deb.debian.org/debian

UBUNTU_SUITES = artful bionic trusty xenial
UBUNTU_MIRROR ?= http://$(patsubst http://%,%,$(APT_PROXY))archive.ubuntu.com/ubuntu

SUDO = /usr/bin/sudo
DEBOOTSTRAP = /usr/sbin/debootstrap
DEBOOTSTRAP_FLAGS = --variant=minbase
TAR = /bin/tar

all: $(DEBIAN_SUITES) $(UBUNTU_SUITES)

push:
	docker push $(NAMESPACE)/debian
	docker push $(NAMESPACE)/ubuntu

clean:
	$(SUDO) rm -rf chroot-*
	rm -f *.tar

$(DEBIAN_SUITES): % : debian-%.tar

$(UBUNTU_SUITES): % : ubuntu-%.tar

%.tar: chroot-%
	$(SUDO) $(TAR) -C $< -c . -f $@

chroot-debian-%:
	$(SUDO) $(DEBOOTSTRAP) $(DEBOOTSTRAP_FLAGS) $* $@ $(DEBIAN_MIRROR)
	$(SUDO) cp setup.sh $@/tmp/setup.sh
	$(SUDO) chmod +x $@/tmp/setup.sh
	$(SUDO) chroot $@ /tmp/setup.sh debian $* $(DEBIAN_MIRROR)
	$(SUDO) rm -f $@/tmp/setup.sh

chroot-ubuntu-%:
	$(SUDO) $(DEBOOTSTRAP) $(DEBOOTSTRAP_FLAGS) $* $@ $(UBUNTU_MIRROR)
	$(SUDO) cp setup.sh $@/tmp/setup.sh
	$(SUDO) chmod +x $@/tmp/setup.sh
	$(SUDO) chroot $@ /tmp/setup.sh ubuntu $* $(UBUNTU_MIRROR)
	$(SUDO) rm -f $@/tmp/setup.sh

import-all:
	./import.sh

images:
	$(MAKE) -C $@

.PHONY: images
