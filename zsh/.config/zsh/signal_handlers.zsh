TRAPUSR1() {
	mode="$(darkmanctl get)"
	if [ "$mode" = "dark" ] ; then
		theme.sh tokyo-night
		# echo "DARK"
		# echo "$mode"
	elif [ "$mode" = "light" ] ; then
		theme.sh everforest-light

		# echo "LIGHT"
		# echo "$mode"
	fi
}

