#!/bin/bash

# UTILS & FUNCTIONS
pm_install() { sudo pacman -Sd --noconfirm --needed "$@"; }

# xdg dirs
pm_install xdg-user-dirs
xdg-user-dirs-update

# TODO: ROCM
pm_install mesa vulkan-radeon libva-utils
# sudo pacman -S --noconfirm --needed gstreamer gst-plugins-base gst-plugins-good
sudo usermod -aG video $USER

# audio
pm_install pipewire pipewire-dinit
dinitctl -u enable pipewire
pm_install pipewire-pulse pipewire-pulse-dinit
dinitctl -u enable pipewire-pulse

# Terminal
pm_install fish starship fzf nano
sudo chsh -s /usr/bin/fish $USER

# Greeter + graphical init
#pm_install greetd greetd-dinit greetd-tuigreet
#echo -e '[terminal]\nvt = current' > /etc/greetd/config.toml
#echo -e '\n[default_session]' >> /etc/greetd/config.toml
#echo 'command = "tuigreet --time --cmd niri --session"' >> /etc/greetd/config.toml
#echo -e '\n[initial_session]' >> /etc/greetd/config.toml
#echo 'command = "niri --session"' >> /etc/greetd/config.toml
#echo 'user = "luka"' >> /etc/greetd/config.toml
#sudo dinitctl enable greetd

# Hyprland install
pm_install niri xdg-desktop-portal-gnome pipewire-jack
pm_install alacritty xwayland-satellite fuzzel waybar
pm_install gnome-keyring pantheon-polkit-agent
# FIXME: Init o config del polkit ?
#sudo mkdir /etc/dinit.d/user && mkdir /home/$USER/config/niri
#download_from_niri_main resources/dinit/niri /etc/dinit.d/user/niri
#dinitctl -u enable niri
#download_from_niri_main resources/dinit/niri-shutdown /etc/dinit.d/user/niri-shutdown
#dinitctl -u enable niri-shutdown
#download_from_niri_main resources/default-config.kdl /home/$USER/.config/niri/config.kdl

# Editor & browser
pm_install zed vivaldi

# Flatpak support
pm_install flatpak

# Uninstallations
#sudo pacman -Rddsu --noconfirm gpsd v4l-utils
#sudo pacman -Rdd --noconfirm nautilus
#sudo pacman -Rddsu --noconfirm gnome-autoar libnautilus-extension localsearch

# paru install
#sudo pacman -S --needed base-devel git
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si

# Finished c:
# sudo reboot

# fish_add_path -U /home/$USER/.local/bin
