#! /bin/bash

# Check if script is running as non-root user, if not exit.
[ "$EUID" -eq 0 ] && echo 'Must not run as root! =(' && exit 1

# Check to see if yay is already installed, if so exit.
[ -n "$(command -v yay)" ] && echo 'yay already installed! =)' && exit

echo 'Installing yay...'
YAY_LOC="$HOME/Downloads/yay"

# Delete existing download if it exists.  
[ -d $YAY_LOC ] && rm -rf $YAY_LOC

# Clone the yay repo from https://aur.archlinux.org/yay.git .
# Delete downloaded files if it failed to download repo completely.
echo "Cloning yay to $YAY_LOC..."
git clone https://aur.archlinux.org/yay.git $YAY_LOC
[ $? -ne 0 ] && echo 'Unable to clone yay from repository' && rm -rf "$YAY_LOC"  && exit 1

# Builds and installs yay, delete downloaded files if it fails.
# Option s -- Sync packages (Download go)
# Option i -- Install package
# Option r -- Remove packages (Uninstalls go)
# Option c -- Clean build files after install
cd $YAY_LOC && makepkg --noconfirm -sirc
[ $? -ne 0 ] && rm -rf $YAY_LOC && echo 'Failed to install yay!' && cd && exit 1

# Do a system upgrade using yay.
cd && echo 'Installed yay! =)' && yay --noconfirm -Syu
