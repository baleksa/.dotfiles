## Steps after fresh install

### Logging
Install `socklog-void`, enable socklog-unix and nanoklogd services. The logs are saved in sub-directories of /var/log/socklog/, and svlogtail can be used to access them conveniently. Add user to socklog group so he can read logs.

### Dualboot time fix
Add `export HARDWARECLOCK=localtime` to `/etc/rc.conf`. Install `chrony` and enable chronyd service for greater time accuracy.

### Power Management
Use default `acpid`, dont install `elogind` because it will conflict with acpid, install `tlp`, and enable tlp service

### Sway and Wayland
Sway needs XDG_RUNDIR set and access to seats, elogind doesn't work on voidlinux so you have to install `seatd`, add user to _seatd group, start seatd service and then start Sway. Qt5-based applications require installing the qt5-wayland package and setting the environment variable QT_QPA_PLATFORM=wayland-egl to enable their Wayland backend. Some KDE specific applications also require installing the kwayland package.

#### IWD
Use IWD for wireless network. It needs dbus service started or to be started with dbus-launch. IWD clashes with udevd, to surpress udev's message about error with changing net interface prevent IWD from  manipulating the network interfaces in this way by adding:
```
[General]
UseDefaultInterface=true
```
to `/etc/iwd/main.conf`.

#### ZSH
After stowing dotfiles install plugins and clone needed repositories to repos folder, then set up paths if needed. On void `zsh-autosuggestions` and `zsh-syntax-highlighting` are available from official repo. 

#### VScode
Add `"keyboard.dispatch": "keyCode"` to settings.json for swapcapsesc to work with extensions.
