#!/bin/sh

set -e -x

# pass path to the root. Don't let it run without one as it will break your system
if [ "" = "$1" ] ; then 
	echo "You need to specify a path to the target rootfs"
else
	if [ -e "$1" ] ; then
		ROOTFS="$1"
	else 
		echo "Root dir $ROOTFS not found"
	fi
fi

if [ "/" = "ROOTFS" ] ; then echo "Refusing to change your build system's files" ; fi

# set hostname
echo andbot > $ROOTFS/etc/hostname
echo "127.0.0.1 localhost.localdomain localhost" > ${ROOTFS}/etc/hosts
echo "127.0.1.1 andbot andbot" >> ${ROOTFS}/etc/hosts
echo "nameserver 8.8.8.8" > ${ROOTFS}/etc/resolv.conf
echo "nameserver 8.8.4.4" >> ${ROOTFS}/etc/resolv.conf
echo "en_US.UTF-8 UTF-8" >> ${ROOTFS}/etc/locale.gen

cp deb/*.deb ${ROOTFS}/root/
