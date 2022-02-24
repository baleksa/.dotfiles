#!/bin/sh

add_service() {
        [ ! -d /var/service/"$1" ] && sudo ln -s /etc/sv/"$1" /var/service
}
message() {
    echo "$1:"
    echo "=================="
}

message "INSTALLING XTOOLS AND ENABLING NONFREE REPO"
sudo xbps-install -Su -y xtools void-repo-nonfree
message "INSTALLING ZSH AND SETTING IT AS DEFAULT SHELL"
xi -y zsh
sudo chsh -s /bin/zsh "$USER"
message "INSTALLING MESA VGA DRIVERS AND INTEL-UCODE"
xi -y mesa-dri mesa-vaapi mesa-vdpau mesa-vulkan-intel
xi -y intel-ucode
message "DBUS"
xi -y dbus && add_service dbus
message "LOGGING"
xi -y socklog-void &&
	add_service socklog_unix &&
	add_service nanoklogd
message "MAKE LINUX USE LOCALTIME FOR TIME TO BE ACCURATE WITH DUALBOOTING AND SET CHRONY"
echo 'export HARDWARECLOCK=localtime' | sudo tee -a /etc/rc.conf
xi -y chrony && add_service chronyd
message "TLP FOR POWER MANAGEMENT"
xi -y tlp && add_service tlp
message "SEATD"
xi -y seatd && add_service seatd && sudo usermod -a -G _seatd "$USER"
message "SWAY"
xi -y sway swayidle swaylock
xi -y qt5-wayland qt6-wayland
xi -y kwayland
message "IWD"
xi -y iwd && add_service iwd && printf '[General]\nUseDefaultInterface=true' | sudo tee -a /etc/iwd/main.conf
message "ZSH"
xi -y zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-history-substring-search
message "ALACRITTY"
xi -y alacritty
message "PIPEWIRE, ALSA AND BLUETOOTH"
xi -y pipewire libspa-bluetooth alsa-pipewire
sudo mkdir -p /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d
xi -y bluez && add_service bluetoothd && sudo usermod -a -G bluetooth "$USER"
message "INSTALL OTHER PACKAGES"
xargs -a ./manually_installed_packages_void_test xi -y
message "STOW DOTFILES"
xi -y stow
stow */
message "REBOOTING NOW"
sudo reboot now
