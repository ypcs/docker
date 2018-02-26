NAMESPACE = ypcs

APT_PROXY ?=

DEBIAN_SUITES = jessie stretch buster sid
DEBIAN_MIRROR ?= http://$(patsubst http://%,%,$(APT_PROXY))deb.debian.org/debian

UBUNTU_SUITES = artful bionic trusty xenial
UBUNTU_MIRROR ?= http://$(patsubst http://%,%,$(APT_PROXY))archive.ubuntu.com/ubuntu

DISTROS = debian ubuntu

SUDO = /usr/bin/sudo
DEBOOTSTRAP = /usr/sbin/debootstrap
DEBOOTSTRAP_FLAGS = --variant=minbase
TAR = /bin/tar

all: $(DEBIAN_SUITES) $(UBUNTU_SUITES)

include Makefile.debootstrap
include Makefile.docker
include Makefile.vagrant

clean:
	$(SUDO) rm -rf chroot-*
	rm -f *.tar *.box *.img

$(DISTROS): %:
	$(MAKE) $($@_SUITES)

$(DEBIAN_SUITES): % : debian-%.tar

$(UBUNTU_SUITES): % : ubuntu-%.tar

%.tar: chroot-%
	$(SUDO) $(TAR) -C $< -c . -f $@

images:
	$(MAKE) -C $@

.PHONY: images
