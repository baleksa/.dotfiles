TRAPUSR1() {
	mode="$(darkman get)"
	if [ "$mode" = "dark" ]; then
		theme.sh tokyo-night
		export FZF_DEFAULT_OPTS="
	--color=bg+:#292e42,bg:#24283b,spinner:#bb9af7,hl:#565f89,fg:#c0caf5,header:#565f89,info:#7dcfff,pointer:#bb9af7,marker:#7dcfff,fg+:#ffffff,preview-bg:#24283b,prompt:#bb9af7,hl+:#bb9af7
	$FZF_DEFAULT_OPTS_NO_THEME"
	elif [ "$mode" = "light" ]; then
		theme.sh everforest-light
		export FZF_DEFAULT_OPTS="
         --color fg:-1,bg:-1,hl:#268bd2,fg+:#073642,bg+:#eee8d5,hl+:#268bd2
         --color info:#b58900,prompt:#b58900,pointer:#002b36,marker:#002b36,spinner:#b58900
	 $FZF_DEFAULT_OPTS_NO_THEME"
		# echo "LIGHT"
		# echo "$mode"
	fi

}
