#!/bin/sh

# Update sumneko lua language server ( https://github.com/sumneko/lua-language-server ) to the latest release from github

get_latest_version_from_git() {
	# Get latest release from GitHub api
	curl --silent "https://api.github.com/repos/$1/releases/latest" |
		grep '"tag_name":' |         # Get tag line
		sed -E 's/.*"([^"]+)".*/\1/' # Pluck JSON value
}

latest_version=$(
	get_latest_version_from_git "sumneko/lua-language-server"
)
server_tarball="/tmp/lua.tar.gz"
server_location="$GIT_REPOS_DIR/lua-language-server"

if [ -d "$server_location" ]; then
	installed_version=$(
		head -3 "$server_location/changelog.md" | grep '##' | sed -E 's/[^0-9]+?//'
	)
else
        mkdir "$server_location"
        installed_version='none'
fi

if [ "$installed_version" = "$latest_version" ]; then
	echo "The latest $latest_version release of sumneko lua-language-server is already installed!"
	exit 0
else
	printf "Installed release is %s, latest release is %s.\n" "$installed_version" "$latest_version"
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
exit
