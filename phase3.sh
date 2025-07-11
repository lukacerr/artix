#!/bin/bash

# UTILS & FUNCTIONS
pm_install() {
    sudo pacman -Sd --noconfirm --needed "$@"
        --assume-installed nautilus \
        --assume-installed avahi \
        --assume-installed gpsd
}

pm_remove() { sudo pacman -Rddsu "$@"; }

download_file() { sudo curl -fsSL $1 -o $2; }
download_from_niri_main() { download_file "https://raw.githubusercontent.com/YaLTeR/niri/main/$1" $2; }

# basic
echo "luka-pc" > /etc/hostname

# xdg dirs
pm_install xdg-user-dirs
xdg-user-dirs-update

# TODO: ROCM
sudo pacman -S --noconfirm --needed mesa \
    lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver libva-utils
sudo pacman -S --noconfirm --needed gstreamer \
    gst-plugins-base gst-plugins-good
sudo usermod -aG video $USER

# Flatpak support
pm_install flatpak

# Terminal
pm_install fish starship fzf nano
sudo chsh -s $(which fish) $USER

# Niri install
pm_install niri xdg-desktop-portal-gnome pipewire-jack
pm_install alacritty xwayland-satellite fuzzel waybar
pm_install gnome-keyring pantheon-polkit-agent
# FIXME: Init o config del polkit ?
sudo mkdir /etc/dinit.d/user && mkdir /home/$USER/config/niri
download_from_niri_main resources/dinit/niri /etc/dinit.d/user/niri
dinitctl -u enable niri
download_from_niri_main resources/dinit/niri-shutdown /etc/dinit.d/user/niri-shutdown
dinitctl -u enable niri-shutdown
download_from_niri_main resources/default-config.kdl /home/$USER/.config/niri/config.kdl

# dinit compat
pm_install dbus-dinit-user pipewire pipewire-dinit pipewire-pulse pipewire-pulse-dinit

# Editor & b
curl -f https://zed.dev/install.sh | sh
install_copr "sneexy/zen-browser" "zen-browser"

# Greeter + graphical init
#pm_install greetd greetd-dinit greetd-tuigreet
#echo -e '[terminal]\nvt = current' > /etc/greetd/config.toml
#echo -e '\n[default_session]' >> /etc/greetd/config.toml
#echo 'command = "tuigreet --time --cmd niri --session"' >> /etc/greetd/config.toml
#echo -e '\n[initial_session]' >> /etc/greetd/config.toml
#echo 'command = "niri --session"' >> /etc/greetd/config.toml
#echo 'user = "luka"' >> /etc/greetd/config.toml
#sudo dinitctl enable greetd

# Uninstallations
sudo pacman -Rddsu --noconfirm gpsd v4l-utils
sudo pacman -Rdd --noconfirm nautilus
sudo pacman -Rddsu --noconfirm gnome-autoar libnautilus-extension localsearch

# paru install
#sudo pacman -S --needed base-devel git
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si

# Finished c:
# sudo reboot

# fish_add_path -U /home/$USER/.local/bin
