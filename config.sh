#!/bin/sh

set -e -x

export PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin

/var/lib/dpkg/info/dash.preinst install
mkdir -p /var/lib/x11
dpkg --configure -a
dpkg -i /root/*.deb
rm /root/*.deb
adduser andbot --disabled-password --gecos "AndBot"
echo 'Defaults !secure_path' >> /etc/sudoers
echo 'andbot ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

cat >> /home/andbot/.bashrc << 'HEREDOC'
. /etc/bash_completion.d/*
export PATH=~/android/system/out/host/linux-x86/bin:$PATH:/usr/local/sbin:/usr/sbin:/sbin
PS1='`if [ \$? = 0 ]; then echo \[\e[32m\]; else echo \[\e[31m\]; fi`${debian_chroot:+$debian_chroot:}\[\e[0m\]\u@\h:\w\$ '
HEREDOC

mkdir -p /home/andbot/bin /home/andbot/android/system/.repo /home/andbot/.android
ln -s /andbot /home/andbot/bin/
curl http://dl.dropbox.com/u/1213413/cm9/adb > /home/andbot/bin/adb
chmod a+x /home/andbot/bin/adb
echo '0x2080' > /home/andbot/.android/adb_usb.ini
chown -R andbot:andbot /home/andbot
su andbot -c 'curl http://pastebin.com/raw.php?i=FrFJmVtJ > ~/android/system/.repo/local_manifest.xml'
ln -s usr/bin/andbot /andbot

echo AndBot > /etc/debian_chroot

rm /config.sh
