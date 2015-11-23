.PHONY: all clean

SUITE=wheezy

all: rootfs.tar.xz

clean:
	rm -rf rootfs rootfs.tar.xz debootstrap.ts

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
	    $(SUITE) \
	    rootfs \
	    http://mirrordirector.raspbian.org/raspbian/
	chroot rootfs apt-get clean
	date > $@
