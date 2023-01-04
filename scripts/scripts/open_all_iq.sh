#!/bin/sh
tasks="KA IT_ S-A MOZAIK FAL MTRX PUZZLE"
# task1="KA"
# task2="IT_"
# task3="S-A"
# task4="MOZAIK"
# task5="FAL"
# task6="MTRX"
# task7="PUZZLE"
variations="5"

# link_format_string="https://fakultet.totalassessment.net/td2/mila/exe.php?run&t=%s.%s.%s.%s.%s.%s.%s.ENDE&g=male&l=sr&lag=200"
linkbase="https://fakultet.totalassessment.net/td2/mila/exe.php?run&t="
for var in $variations; do
	for task in $tasks; do
		link="$linkbase"
		link="${link}${task}${var}."
		link="${link}ENDE&g=male&l=sr&lag=200"
		firefox-wayland --new-tab "$link"
	done
	# echo "$link"	
	while true; do
		printf "Continue? "
		read -r yn
		case $yn in
		[Yy]*) break ;;
		*) exit ;;
		esac
	done
done
