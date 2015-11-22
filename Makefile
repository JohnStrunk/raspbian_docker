.PHONY: all

BRANCH=$(shell git branch | grep \\* | awk '{ print $$2 }')

test:
	echo $(BRANCH)

all: rootfs.tar.xz

rootfs.tar.xz: debootstrap.ts
	tar cvJf $@ -C rootfs .

debootstrap.ts:
	rm -f $@
	rm -rf rootfs
	debootstrap \
	    --components main,contrib,non-free,rpi \
	    --variant=minbase \
	    --keyring /usr/share/keyrings/raspbian-archive-keyring.gpg \
	    --verbose \
	    $(BRANCH) \
	    rootfs \
	    http://mirrordirector.raspbian.org/raspbian/
	chroot rootfs apt-get clean
	touch $@
