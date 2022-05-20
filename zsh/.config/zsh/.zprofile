if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
    . "$MY_ENV_DIR/.profile"
fi
