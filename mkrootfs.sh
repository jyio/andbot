mkdir rootfs
multistrap -f multi.strap
chroot rootfs /config.sh
