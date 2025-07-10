# xdg dirs
xdg-user-dirs-update

# TODO: Codecs
# TODO: ROCM & drivers
sudo usermod -aG video $USER

# Flatpak support
sudo pacman -S --noconfirm flatpak

# Terminal
sudo pacman -S --noconfirm fish starship fzf
sudo chsh -s $(which fish) $USER

# Niri install
sudo pacman -Sd --needed --noconfirm niri xdg-desktop-portal-gnome pipewire-jack
sudo pacman -Sd --noconfirm alacritty xwayland-satellite fuzzel waybar
sudo pacman -Sd --needed --noconfirm gnome-keyring pantheon-polkit-agent
curl -fsSL \
    https://raw.githubusercontent.com/YaLTeR/niri/main/resources/default-config.kdl \
    -o /home/$USER/.config/niri/config.kdl

# Greeter + graphical init
sudo pacman -Sd --needed --noconfirm greetd greetd-dinit greetd-tuigreet
ln -s /etc/runit/sv/greetd /run/runit/service/ # FIXME
echo -e '[terminal]\nvt = current' > /etc/greetd/config.toml
echo -e '\n[default_session]' >> /etc/greetd/config.toml
echo 'command = "tuigreet --time --cmd niri --session"' >> /etc/greetd/config.toml
echo -e '\n[initial_session]' >> /etc/greetd/config.toml
echo 'command = "niri --session"' >> /etc/greetd/config.toml
echo 'user = "luka"' >> /etc/greetd/config.toml
sudo dinitctl start greetd

# paru install
#sudo pacman -S --needed base-devel git
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si

# Finished c:
sudo reboot
