#!/bin/sh

RED='\033[31m'
PURPLE='\033[35m'
GREEN='\033[32m'
NC='\033[0m' # No Color
ERROR=$RED
INFO=$PURPLE
SUCCES=$GREEN

do_job() {
	succes_msg="DONE!"
	failed_msg="FAILED!"

	hello_msg="$1"
	shift
	colored_echo "$hello_msg" "$INFO"
	"$@"
	exit_code=$?
	if [ "$exit_code" = 0 ]; then
		colored_echo "$succes_msg" "$SUCCES"
	else
		colored_echo "$failed_msg" "$ERROR"
		# exit "$stat"
	fi
}

colored_echo() {
	msg="$1"
	color="$2"
	echo "${color}${msg}${NC}"
}

add_service() {
	[ ! -d /var/service/"$1" ] && sudo ln -s /etc/sv/"$1" /var/service
}
