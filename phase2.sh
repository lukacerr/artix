#!/bin/bash

# UTILS & FUNCTIONS
pm_install() { pacman -Sd --noconfirm --needed "$@"; }

# Clock
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc

# Locales
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
echo 'export LANG="en_US.UTF-8"' >> /etc/locale.conf
echo 'export LC_COLLATE="C"' >> /etc/locale.conf
locale-gen

# Host
echo "luka-pc" > /etc/hostname

# Repos support
pm_install artix-archlinux-support
echo -e '\n[omniverse]' >> /etc/pacman.conf
echo 'Server = https://artix.sakamoto.pl/omniverse/$arch' >> /etc/pacman.conf
echo 'Server = https://eu-mirror.artixlinux.org/omniverse/$arch' >> /etc/pacman.conf
echo 'Server = https://omniverse.artixlinux.org/$arch' >> /etc/pacman.conf
echo -e '\n[extra]\nInclude = /etc/pacman.d/mirrorlist-arch' >> /etc/pacman.conf
echo -e '\n[multilib]\nInclude = /etc/pacman.d/mirrorlist-arch' >> /etc/pacman.conf
pacman-key --populate archlinux
pacman -Sy --noconfirm

# sudo setup & reboot
pm_install sudo
echo -e "\n# MANUAL MODIFICATION: %wheel w/nopasswd" >> /etc/sudoers
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
usermod -aG wheel luka

# dbus user activation + reboot c:
pm_install turnstile turnstile-dinit
dinitctl enable turnstiled
sudo reboot
