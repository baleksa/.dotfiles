#!/bin/sh

# Edit an old or make a new script

if [ "$#" = "0" ]; then
    script="$(find /home/baleksa/.local/bin/scripts/ -type f | fzf)"
    script=${script:=$MY_SCRIPTS_PATH}
else 
    script="$MY_SCRIPTS_PATH/$1"
fi
if [ ! -f "$script" ]; then
   touch "$script"
   chmod +x "$script"
fi
nvim "$script"
[ ! -s "$script" ] && rm "$script"
