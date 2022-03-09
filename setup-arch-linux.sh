#!/bin/bash

mkdir -p ~/Softwares

sudo pacman -S vim cmake aria2 xclip alacritty \
    a52dec faac faad2 flac jasper lame libdca \
    libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 \
    xvidcore vlc p7zip util-linux libxcrypt libxcrypt-compat \
    mythes-en gst-plugins-good ttf-droid jdk11-openjdk icedtea-web \
    ttf-ubuntu-font-family ttf-anonymous-pro ufw \
    gst-libav libdvdnav fuse-exfat libvorbis \
    libdvdcss lame libmpeg2 libtheora libxv libdvdread \
    gstreamer deja-dup

# Final manual steps
# set GRUB_TIMEOUT=0; GRUB_HIDDEN_TIMEOUT=0; GRUB_DEFAULT=saved
# then run `sudo grub-mkconfig -o /boot/grub/grub.cfg`

# Programming languages

# Python
sudo pacman -S --noconfirm python-virtualenv python-pip
# Golang
sudo pacman -S --noconfirm go go-tools

# Rust
sudo pacman -S --noconfirm rustup
rustup default stable

# Haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install v14
npm install -g npm
npm install -g typescript
npm install -g yarn
npm install -g create-react-app
nvm install v16
npm install -g npm
npm install -g typescript
npm install -g yarn
npm install -g create-react-app

# Elm
curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
gunzip elm.gz
chmod +x elm
sudo mv elm /usr/local/bin/
rm -f elm.gz

# Infrastructure Tools

# Docker
sudo pacman -S --noconfirm docker docker-compose
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker $(whoami)

mkdir -p ~/.docker
cp docker/config.json ~/.docker/config.json

# AWS CLI
sudo pacman -S aws-cli

# Google Cloud SDK
git clone https://aur.archlinux.org/google-cloud-sdk.git \
    Softwares/google-cloud-sdk
cd ~/Softwares/google-cloud-sdk
makepkg -si
cd ~

# Terraform
sudo pacman -S terraform

# Kubernetes (exclude the cluster running tools)
sudo pacman -S kubectl kubectx k9s

# Other developer tools

# Slack
git clone https://aur.archlinux.org/unetbootin.git \
    Softwares/unetbootin
cd ~/Softwares/unetbootin
makepkg -si
cd ~

git clone https://aur.archlinux.org/slack-desktop.git \
    Softwares/slack-desktop
cd ~/Softwares/slack-desktop
makepkg -si
cd ~

# Tor Browser
git clone https://aur.archlinux.org/tor-browser.git \
    Softwares/tor-browser
cd ~/Softwares/tor-browser
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org
makepkg -si
cd ~

# Postman

git clone https://aur.archlinux.org/postman-bin.git \
    Softwares/postman-bin
cd ~/Sofwares/postman-bin
makepkg -si
cd ~

# "Normal" user software

sudo pacman -S libreoffice-fresh

curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import -
git clone https://aur.archlinux.org/spotify.git \
    Softwares/spotify
cd ~/Softwares/spotify
makepkg -si
cd ~

git clone https://aur.archlinux.org/telegram-desktop-bin.git \
    Softwares/telegram-desktop-bin.git
cd ~/Softwares/telegram-desktop-bin
makepkg -si
cd ~

git clone https://aur.archlinux.org/zoom.git \
    Softwares/zoom
cd ~/Sofwares/zoom
makepkg -si
cd ~

git clone https://aur.archlinux.org/unetbootin.git \
    Softwares/unetbootin
cd ~/Softwares/unetbootin
makepkg -si
cd ~

# Remove orphans
# sudo pacman -Rns $(pacman -Qtdq)

