# UTILS & FUNCTIONS
pm_install() {
    sudo pacman -Sd --noconfirm --needed "$@"
        --assume-installed nautilus \
        --assume-installed avahi \
        --assume-installed gpsd
}

download_file() { sudo curl -fsSL $1 -o $2; }
download_from_niri_main() { download_file "https://raw.githubusercontent.com/YaLTeR/niri/main/$1" $2; }

# xdg dirs
pm_install xdg-user-dirs
xdg-user-dirs-update

# TODO: Codecs
# TODO: ROCM & drivers
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
download_from_niri_main resources/dinit/niri-shutdown /etc/dinit.d/user/niri-shutdown
download_from_niri_main resources/default-config.kdl /home/$USER/.config/niri/config.kdl

# pipewire autostart
sudo pacman -S dbus-dinit-user pipewire-dinit pipewire-pulse-dinit
dinitctl -u enable pipewire
dinitctl -u enable pipewire-pulse

# Greeter + graphical init
#pm_install greetd greetd-dinit greetd-tuigreet
#echo -e '[terminal]\nvt = current' > /etc/greetd/config.toml
#echo -e '\n[default_session]' >> /etc/greetd/config.toml
#echo 'command = "tuigreet --time --cmd niri --session"' >> /etc/greetd/config.toml
#echo -e '\n[initial_session]' >> /etc/greetd/config.toml
#echo 'command = "niri --session"' >> /etc/greetd/config.toml
#echo 'user = "luka"' >> /etc/greetd/config.toml
#sudo dinitctl enable greetd

# dinit
dinitctl enable turnstiled

# paru install
#sudo pacman -S --needed base-devel git
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si

# Finished c:
sudo reboot
