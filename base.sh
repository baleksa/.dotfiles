#!/bin/sh

. ./utils.sh

setup_xdg_runtime_dir() {
	dirname="$(id -u)"
	mkdir /run/user/"$dirname"
	chmod 700 /run/user/"$dirname"
	chown "$USER" /run/user/"$dirname"
	sudo tee /etc/profile.d/set_xdg_runtime_dir.sh <<'script'
#!/bin/sh
if [ "$(id -u)" -ge 1000 ]; then
	export XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi
script

}

setup_dbus() {
	:
}

init_xbps() {
	do_job "Doing initial update of xbps" \
		sudo xbps-install -Sy xbps

	do_job "Doing initial update of xbps" \
		sudo xbps-install -Syu

	do_job "Installing xtools and adding the rest of void repos:" \
		sudo xbps-install -Sy xtools void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
}

gonfigure_git() {
	# HACK: hardcoded values
	git config --global user.email "skr.aleksa@gmail.com"
	git config --global user.name "Aleksa Blagojević"
}

configure_ssh() {
	true
}

pipewire_setup() {
	xi -Syu pipewire
	mkdir -p "${XDG_CONFIG_HOME}/pipewire/pipewire.conf.d"
	echo 'context.exec = [ { path = "/usr/bin/wireplumber" args = "" } ]' \
		>"""$XDG_CONFIG_HOME"/pipewire/pipewire.conf.d/10-wireplumber.conf

}
