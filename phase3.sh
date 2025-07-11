#!/bin/bash

# UTILS & FUNCTIONS
pm_install() { sudo pacman -Sd --noconfirm --needed "$@"; }
download_niri_resource() {
    sudo curl -fsSL https://raw.githubusercontent.com/YaLTeR/niri/main/resources/$1 -o $2
}

# xdg dirs
pm_install xdg-user-dirs
xdg-user-dirs-update

# TODO: ROCM
pm_install mesa vulkan-radeon libva-utils
# pm_install gstreamer gst-plugins-base gst-plugins-good
sudo usermod -aG video $USER

# audio
pm_install pipewire pipewire-dinit
dinitctl -u enable pipewire
pm_install pipewire-pulse pipewire-pulse-dinit
dinitctl -u enable pipewire-pulse

# Terminal
pm_install fish starship fzf nano fastfetch
sudo chsh -s /usr/bin/fish $USER

# Greeter + graphical init
#pm_install greetd greetd-dinit # greetd-tuigreet
#echo -e '[terminal]\nvt = current' > /etc/greetd/config.toml
#echo -e '\n[default_session]' >> /etc/greetd/config.toml
#echo 'command = "tuigreet --time --cmd niri --session"' >> /etc/greetd/config.toml
#echo -e '\n[initial_session]' >> /etc/greetd/config.toml
#echo 'command = "niri --session"' >> /etc/greetd/config.toml
#echo 'user = "luka"' >> /etc/greetd/config.toml
#sudo dinitctl enable greetd

# Niri install
pm_install niri xdg-desktop-portal-gnome pipewire-jack
pm_install alacritty fuzzel waybar xwayland-satellite
pm_install gnome-keyring pantheon-polkit-agent
# FIXME: Init o config del polkit ?
#sudo mkdir /etc/dinit.d/user && mkdir /home/$USER/config/niri

# Niri configs + dinit
mkdir .config/niri
download_niri_resource "default-config.kdl" ".config/niri/config.kdl"
sudo mkdir /usr/local/share/xdg-desktop-portal
download_niri_resource "niri-portals.conf" "/usr/local/share/xdg-desktop-portal/niri-portals.conf"
download_niri_resource "dinit/niri" "/etc/dinit.d/user/niri"
download_niri_resource "dinit/niri-shutdown" "/etc/dinit.d/user/niri-shutdown"
dinitctl -u enable niri
dinitctl -u enable niri-shutdown

# Editor & browser
pm_install zed vivaldi

# Flatpak support
# pm_install flatpak

# Uninstallations
#sudo pacman -Rddsu --noconfirm gpsd v4l-utils
#sudo pacman -Rdd --noconfirm nautilus
#sudo pacman -Rddsu --noconfirm gnome-autoar libnautilus-extension localsearch

# paru install
pm_install base-devel git
git clone https://aur.archlinux.org/paru
# cd paru
# makepkg -si

# Finished c:
sudo pacman -Syu --noconfirm
# sudo reboot
