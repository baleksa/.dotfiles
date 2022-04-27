#!/bin/sh

# Update sumneko lua language server ( https://github.com/sumneko/lua-language-server ) using latest release from github

get_latest_release_from_git() {
	# Get latest release from GitHub api
	curl --silent "https://api.github.com/repos/$1/releases/latest" |
		grep '"tag_name":' |         # Get tag line
		sed -E 's/.*"([^"]+)".*/\1/' # Pluck JSON value
}

latest_release=$(
	get_latest_release_from_git "sumneko/lua-language-server"
)
server_tarball="/tmp/lua.tar.gz"
server_location="$GIT_REPOS_DIR/lua-language-server"

if [ -d "$server_location" ]; then
	old_release=$(
		head -3 "$server_location/changelog.md" | grep '##' | sed -E 's/[^0-9]+?//'
	)
else
        mkdir "$server_location"
        old_release='none'
fi

if [ "$old_release" = "$latest_release" ]; then
	echo "The latest $latest_release release of sumneko lua-language-server is already installed!"
	exit
else
	printf "Installed release is %s, latest release is %s.\n" "$old_release" "$latest_release"
	rm -rf "$server_location"
	mkdir "$server_location"
fi

echo "Getting the latest release from github."
curl -s https://api.github.com/repos/sumneko/lua-language-server/releases/latest |
	grep "browser_download_url.*linux-x64" |
	cut -d'"' -f4 |
	wget -q -i - -O "$server_tarball"

echo "Uncompressing it to $server_location."
tar xf "$server_tarball" -C "$server_location"

echo "Done!"
