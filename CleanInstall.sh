#!/bin/bash

# Script to purge unnecessary packages, remove MOTD news, install and configure applications, and customize system settings
# Run as root or with sudo

echo "Purging the following packages: apport, apport-symptoms, popularity-contest, ubuntu-report, whoopsie"

# Purge commands
sudo apt purge -y apport
sudo apt purge -y apport-symptoms
sudo apt purge -y popularity-contest
sudo apt purge -y ubuntu-report
sudo apt purge -y whoopsie

# Remove MOTD news
echo "Removing MOTD news script..."
sudo rm /etc/update-motd.d/50-motd-news

# Disable apport crash notifications
echo "Disabling apport crash notifications..."
gsettings set com.ubuntu.update-notifier show-apport-crashes false

# Disable notifications on the lock screen
echo "Disabling notifications on the lock screen..."
gsettings set org.gnome.desktop.notifications show-in-lock-screen false

# Disable recent file tracking
echo "Disabling recent file tracking..."
gsettings set org.gnome.desktop.privacy remember-recent-files false

# Disable idle delay
echo "Disabling idle delay..."
gsettings set org.gnome.desktop.session idle-delay 0

# Disable screen locking
echo "Disabling screen locking..."
gsettings set org.gnome.desktop.screensaver lock-enabled false

# Disable lock-on-suspend
echo "Disabling lock-on-suspend..."
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false

# Enable permanent delete option in Nautilus
echo "Enabling 'Delete Permanently' in Nautilus..."
gsettings set org.gnome.nautilus.preferences show-delete-permanently true

# Show hidden files in Nautilus
echo "Enabling 'Show Hidden Files' in Nautilus..."
gsettings set org.gnome.nautilus.preferences show-hidden-files true

# Install software
echo "Installing additional software..."
sudo apt install -y bleachbit keepassxc clamav clamav-daemon clamtk mat2 flatpak gnome-software-plugin-flatpak

# Configure ClamAV
echo "Configuring ClamAV..."
sudo systemctl stop clamav-freshclam
sudo systemctl enable clamav-freshclam --now

# Add and configure Flathub repository
echo "Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install LibreWolf via Flatpak
echo "Installing LibreWolf via Flatpak..."
flatpak run io.gitlab.librewolf-community

# Add VeraCrypt PPA and install VeraCrypt
echo "Adding VeraCrypt PPA and installing VeraCrypt..."
sudo add-apt-repository ppa:unit193/encryption -y
sudo apt update
sudo apt install -y veracrypt

# Clean up
echo "Cleaning up..."
sudo apt autoremove -y
sudo apt autoclean -y

echo "System setup and customization completed successfully!"
