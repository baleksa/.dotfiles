#!/bin/sh

# Edit an old or make a new note

if [ "$#" = "0" ]; then
	note="$(find -H "$MY_NOTES_DIR" -name '*.md' | fzf)"
	note=${note:=$MY_NOTES_DIR}
else
	note="$MY_NOTES_DIR/$1"
	if [ ! -f "$note" ]; then
		# touch "$note"
		echo "Enter a title for the note:"
		read -r title
		printf "%s\ntitle: %s\ncreated: %s\n%s\n" '---' "$title" "$(date -u -Is)" '---' >> "$note"
	fi
fi

nvim "$note"
[ -e "$note" ] && [ ! -s "$note" ] && rm "$note"