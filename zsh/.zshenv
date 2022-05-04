export ZDOTDIR=$HOME/.config/zsh

export GOPATH="$HOME/go"

export JAVA_HOME="/usr/lib/jvm/openjdk17"

ANDROID_SDK_PATH="$HOME/Android/Sdk"
ANDROID_STUDIO_PATH="$HOME/Repositories/android-studio/bin"

export MY_SCRIPTS_PATH="$HOME/.local/bin/scripts"

export PATH="$MY_SCRIPTS_PATH:$HOME/.local/bin:$PATH:$ANDROID_STUDIO_PATH:$GOPATH/bin:$ANDROID_SDK_PATH/emulator:$ANDROID_SDK_PATH/tools"

export _JAVA_AWT_WM_NONREPARENTING=1 # Fix gray window in java apps
export QT_QPA_PLATFORM=wayland-egl
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export EDITOR=nvim
export TERMINAL="alacritty"
export BROWSER="firefox-wayland"
