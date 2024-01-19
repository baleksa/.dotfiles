#!/bin/sh

. ./utils.sh

setup_greetd_tuigreet() {
	xi -Sy greetd tuigreet || exit
	echo "Installed greetd, tuigreet."
	{
		sudo rm /var/service/agetty-tty1 &&
			sudo ln -s /etc/sv/greetd /var/service
	} || exit
	echo "Removed agetty-tty1 service, added greetd service."
	sudo useradd -M -G video greeter || exit
	echo "Make greeter user and added it to video group"
	sudo chmod -R go+r /etc/greetd/ || exit
	echo "Set /etc/greetd MOD"
	sudo tee /etc/greetd/config.toml <<-EOF
		[terminal]
		vt = 1

		[default_session]
		command = "tuigreet --cmd '\$SHELL --login'"
		user = "greeter"
	EOF
	echo 'Set tuigreet to run default login shell'
}

setup_asdf() {
	# HACK: version is hardcoded!
	[ ! -d ~/.asdf ] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3

	xi -Syu python3 gcc make python3-pip
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	asdf install nodejs latest
	asdf global nodejs latest

	xi -Syu openssl openssl-devel libyaml libyaml-devel zlib zlib-devel autoconf bison gperf ruby gmp gmp-devel
	asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
	asdf install ruby latest
	asdf global ruby latest
}

setup_inotify_limits() {
	sudo tee -a /etx/sysctl.conf <<-SEP
		# This fixes. WezTerm didn't start because notify was hitting the limit too
		# often.
		# https://scribe.rip/@ivanermilov/how-to-fix-inotify-cannot-be-used-reverting-to-polling-too-many-open-files-bb1c1437dbf
		# https://github.com/wez/wezterm/issues/3027
		fs.inotify.max_user_instances=10000
		fs.inotify.max_user_watches=640000
	SEP
}
