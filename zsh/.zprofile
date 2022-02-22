if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  export XDG_RUNTIME_DIR=~/.swayrun
  # export WAYLAND_DEBUG=1
  dbus-launch --exit-with-session sway
fi
