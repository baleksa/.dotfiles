#!/bin/sh

# Update neovim to the latest stable release from github

get_latest_git_release() {
	# Get latest release from GitHub api
	curl --silent "https://api.github.com/repos/$1/releases/latest" |
		grep '"tag_name":' |         # Get tag line
		sed -E 's/.*"([^"]+)".*/\1/' # Pluck JSON value
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

latest_stable_version=$(
	get_latest_git_release "neovim/neovim" | cut -c2-
)

installed_version=$(nvim -v | sed 's/.*NVIM v//;1q')

if [ "$latest_stable_version" = "$installed_version" ]; then
	echo "The latest $latest_stable_version stable version of neovim is already installed!"
	exit 0
fi


tmp_tarball="/tmp/neovim.tar.gz"
echo "Getting the latest release from github."
curl -s https://api.github.com/repos/neovim/neovim/releases/latest |
	grep "browser_download_url.*linux.*64.*tar" |
	sed 1q |
	cut -d'"' -f4 |
	wget -q -i - -O "$tmp_tarball"

install_location="$GIT_REPOS_DIR"

if [ -d "$install_location/neovim" ]; then
    echo "Removing an old install of neovim."
    rm -rf "$install_location/neovim"
    rm "$HOME/.local/bin/nvim"
fi

echo "Uncompressing it to $install_location."
tar xf "$tmp_tarball" -C "$install_location"
mv "$install_location/nvim-linux64" "$install_location/neovim"
echo "Making $install_location/neovim/bin/nvim link in $HOME/.local/bin/ ."
ln -s "$install_location/neovim/bin/nvim" "$HOME/.local/bin"
exit