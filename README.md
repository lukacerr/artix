# Artix installation

## Phase 1

- Enter on CD/ISO, no disk
- Login with `root`

**In `cfdisk`**

- GPT label
- efi 512MiB ESP
- swap (custom)GB swap
- root (rest)GB fs

**Then:**

```sh
# Format partitions
mkfs.fat -F 32 /dev/???1
fatlabel /dev/???1 ESP
mkswap -L SWAP /dev/???2
mkfs.ext4 -L ROOT /dev/???3

# Mount partitions
mount /dev/disk/by-label/ROOT /mnt
mkdir /mnt/boot && mkdir /mnt/boot/efi && mkdir /mnt/home
swapon /dev/disk/by-label/SWAP
mount /dev/disk/by-label/ESP /mnt/boot/efi

# Open NTPD
dinitctl start ntpd

# Base bootstrap + Fstab generation
basestrap /mnt base dinit elogind-dinit linux-zen linux-firmware
fstabgen -U /mnt >> /mnt/etc/fstab
artix-chroot /mnt # chroot c:

# Bootloader
pacman -S --noconfirm grub os-prober efibootmgr amd-ucode
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg

# User setup
passwd # root pw
useradd -m luka
passwd luka

# DHCP setup
pacman -S dhcpcd connman-dinit
ln -s ../connmand /etc/dinit.d/boot.d/

# Finished
exit
umount -R /mnt
reboot
```

## Phase 2

- Login w/root user
- Curl and run phase 2 script:

```sh
curl -f https://raw.githubusercontent.com/lukacerr/artix/main/phase2.sh | bash
```

_Expect reboot at the end._

## Phase 3

- Login w/non-root user
- Curl and run phase 3 script:

```sh
curl -f https://raw.githubusercontent.com/lukacerr/artix/main/phase3.sh | sh
```
