#!/bin/sh

# Edit an old or make a new script

if [ "$#" = "0" ]; then
	script="$(find -H "$MY_SCRIPTS_DIR" -type f | fzf)"
	script=${script:=$MY_SCRIPTS_DIR}
else
	script="$MY_SCRIPTS_DIR/$1"
	if [ ! -f "$script" ]; then
		touch "$script"
		chmod +x "$script"
	fi
fi
nvim "$script"
[ -e "$script" ] && [ ! -s "$script" ] && rm "$script"
