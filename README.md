# scripts
Various scripts for deployment, etc.

```
backup-system.sh          == Script I wrote to backup my system, files in backup-system.includes are rsynced
compton-toggle.sh         == Toggle compton compositor (I map it to ALT+SHIFT+F12 like KDE since I use XFCE)
cross-compiler-install.sh == Install GCC/Binutils, pass it the architecture
decrypt-backup-drive.sh   == Exactly what it says
deploy-tar-daemon.sh      == Same as above but watches for /tmp.site, add the cronjob in the TXT file
deploy-tar.sh             == Configurable script to deploy the contents of a tarball to Apache2
encrypted-socks-tunnel.sh == Creates secure SOCKS proxy over SSH to remote server
randomize-disk.sh         == Randomizes a disk quicker than most methods.
restore-system.sh         == Grabs system tarball from backup server and restores it.
tar-filesystem.sh         == Modified script from ArchWiki to backup my system minus /home
unmount-backup-drive.sh   == Excactly what it says
xbacklight.sh             == Assign to hotkeys if ACPI is broken for your screen dimming
```
