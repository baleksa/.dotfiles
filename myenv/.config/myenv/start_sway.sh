#!/bin/sh
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export _JAVA_AWT_WM_NONREPARENTING=1 # Fix gray window in java apps
export QT_QPA_PLATFORM=wayland-egl
# export GTK_BACKED=wayland
# export WAYLAND_DEBUG=1 # Uncomment this line to enable more verbose logging
# # D-Bus
# # If the session bus is not available it is spawned and wrapper round our program
# # Otherwise we spawn our program directly
# drs=
# if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
#     drs=dbus-run-session
# fi
# "$drs" sway
exec sway
