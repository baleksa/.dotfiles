#!/bin/sh

CURRENT_PROFILE=$(pactl info | grep Default\ Sink | cut -d\. -f4)
case "$CURRENT_PROFILE" in
"analog-stereo")
	pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:hdmi-stereo+input:analog-stereo
	;;
"hdmi-stereo")
	pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo
	;;
esac
