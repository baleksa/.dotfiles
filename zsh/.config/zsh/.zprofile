if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  export XDG_RUNTIME_DIR=~/.run
  # export WAYLAND_DEBUG=1 # Uncomment this line to enable more verbose logging
  dbus-launch --exit-with-session sway
fi
