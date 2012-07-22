env = Environment()
Export('env')

if 'debian' in COMMAND_LINE_TARGETS:
	SConscript('deb/SConscript')

env.Alias('andbotfs','andbotfs/etc/debian_chroot')
env.Command('andbotfs/etc/debian_chroot',None,'/usr/sbin/multistrap -f multi.strap && /bin/mount -o bind /proc andbotfs/proc && /usr/sbin/chroot andbotfs /config.sh && /bin/umount andbotfs/proc')

env.Alias('all','andbot.run')
env.Depends('andbot.run','andbotfs')
env.Command('andbot.run',None,'makeself --notemp andbotfs andbot.run "AndBot Bacon Jelly Bean Maker <http://inportb.com/>" ./andbot')

env.Command('repo',None,'wget https://dl-ssl.google.com/dl/googlesource/git-repo/repo && chmod +x repo')
