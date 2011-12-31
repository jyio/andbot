#!/bin/sh

set -e -x

/var/lib/dpkg/info/dash.preinst install
mkdir -p /var/lib/x11
dpkg --configure -a
adduser andbot --disabled-password --gecos "AndBot"
echo 'Defaults !secure_path' >> /etc/sudoers
echo 'andbot ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

cat >> /home/andbot/.bashrc << 'HEREDOC'
. /etc/bash_completion.d/*
PS1='`if [ \$? = 0 ]; then echo \[\e[32m\]; else echo \[\e[31m\]; fi`${debian_chroot:+$debian_chroot:}\[\e[0m\]\u@\h:\w\$ '
HEREDOC

cat >> /etc/bash_completion.d/andbot << 'HEREDOC'
_andbot_show() {
	local cur
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=($(compgen -W 'init sync vendor brunch mka make manifest github-https github-git release-512 release-2048 bacon' -- $cur))
}
complete -F _andbot_show andbot
HEREDOC

mkdir -p /home/andbot/bin /home/andbot/android/system/.repo /home/andbot/.android
ln -s /andbot /home/andbot/bin/
curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > /home/andbot/bin/repo
curl http://dl.dropbox.com/u/1213413/cm9/adb > /home/andbot/bin/adb
chmod a+x /home/andbot/bin/repo /home/andbot/bin/adb
echo '0x2080' > /home/andbot/.android/adb_usb.ini
chown -R andbot:andbot /home/andbot
su andbot -c 'curl http://pastebin.com/raw.php?i=FrFJmVtJ > ~/android/system/.repo/local_manifest.xml'

rm /config.sh
