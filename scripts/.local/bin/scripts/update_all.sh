#!/bin/sh

# RED='\033[31m'
PURPLE='\033[35m'
GREEN='\033[32m'
NC='\033[0m' # No Color

do_job() {
    hello_msg="$1"
    shift
    bye_msg="$1"
    shift
    colored_echo "$hello_msg" "$PURPLE"
    "$@"
    colored_echo "$bye_msg" "$GREEN"
}

colored_echo() {
	msg="$1"
	color="$2"
	echo "${color}${msg}${NC}"
}

update_nvim() {
	cwd=$(pwd)
        echo test
	cd "$GIT_REPOS_DIR/neovim" || return
	git checkout master 2>/dev/null
	git pull --rebase
	git checkout stable 2>/dev/null
	latest_stable_version=$(git log | sed '5q;d' | sed 's/.*NVIM //')".0"
	installed_version=$(nvim -v | sed 's/.*NVIM v//;1q')
        printf "The latest stable version: %s\n" "$latest_stable_version"
        printf "Installed version: %s\n" "$installed_version"
	if [ "$latest_stable_version" = "$installed_version" ]; then
		colored_echo "Neovim is already up to date with the latest stable version" "$GREEN"
		return
        fi
	make CMAKE_BUILD_TYPE=Release
	sudo make install
	cd "$cwd" || exit
}

# colored_echo "Updating xbps packages:" "$PURPLE"
# xi -Su
# colored_echo "Done!" "$GREEN"
do_job "Updating xbps packages:" "Done!" xi -Su

# colored_echo "Updating sumneko lua language server:" "$PURPLE"
# update_sumneko_server
# colored_echo "Done!" "$GREEN"
do_job "Updating sumneko lua language server:" "Done!" update_sumneko_server.sh

# colored_echo "Updating neovim from github" "$PURPLE"
# update_nvim
# colored_echo "Done!" "$GREEN"
do_job "Updating neovim from github" "Done!" update_nvim

# colored_echo "Updating neovim packages via packer.nvim:" "$PURPLE"
# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
# colored_echo "Done!" "$GREEN"
do_job "Updating neovim packages via packer.nvim:" "\nDone!" nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
