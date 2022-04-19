#!/bin/sh

# Edit an old or make a new script

script="$MY_SCRIPTS_PATH/$1"
if [ ! -f "$script" ]; then
   touch "$script"
   chmod +x "$script"
fi
nvim "$script"
[ ! -s "$script" ] && rm "$script"
