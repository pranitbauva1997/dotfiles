#!/bin/bash

mkdir -p ~/Softwares

sudo pacman -S --noconfirm vim cmake aria2 xclip alacritty \
    a52dec faac faad2 flac jasper lame libdca \
    libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 \
    xvidcore vlc p7zip util-linux libxcrypt libxcrypt-compat \
    mythes-en gst-plugins-good ttf-droid jdk11-openjdk icedtea-web \
    ttf-ubuntu-font-family ttf-anonymous-pro ufw \
    gst-libav libdvdnav fuse-exfat libvorbis \
    libdvdcss lame libmpeg2 libtheora libxv libdvdread \
    gstreamer deja-dup ctags tree nload btop jdk17-openjdk dbeaver \
    keepassxc code obsidian gedit

# Network tools
sudo pacman -S --noconfirm traceroute nmap wireshark-qt

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
# curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Node.js
yay -S --noconfirm nvm

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

# Databases

sudo pacman -S --noconfirm postgres

sudo pacman -S --noconfirm redis

# TODO: install TimescaleDB


## Setup Postgres

## Setup TimescaleDB

## Setup Redis

# Infrastructure Tools

# Docker
sudo pacman -S --noconfirm docker docker-compose
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker $(whoami)

mkdir -p ~/.docker
cp docker/config.json ~/.docker/config.json

# AWS CLI
sudo pacman -S --noconfirm aws-cli

# Google Cloud SDK
yay -S --noconfirm google-cloud-sdk

# Terraform
sudo pacman -S --noconfirm terraform

# Kubernetes (exclude the cluster running tools)
sudo pacman -S --noconfirm kubectl kubectx k9s

# Below command is error prone, run manually
# yay -S --noconfirm lens

# Other developer tools

# Slack
yay -S --noconfirm slack-desktop

# Tor Browser
sudo pacman -S --noconfirm torbrowser-launcher

# Postman
yay -S --noconfirm postman-bin

# Insomnia
yay -S --noconfirm insomnia

# "Normal" user software

sudo pacman -S --noconfirm libreoffice-fresh vlc chromium gparted

yay -S --noconfirm spotify

yay -S --noconfirm telegram-desktop

yay -S --noconfirm zoom

yay -S --noconfirm sioyek

sudo pacman -S --noconfirm neomutt

# Jet Brains IDEs
yay -S --noconfirm pycharm-professional

# Remove orphans
# sudo pacman -Rns $(pacman -Qtdq)

# Setup HDD

# Setup Neomutt

### Tip: Be careful to not set PGP passphrase or find a workaround

## Run mbsync -a 

# Setup Rclone

# Setup firefox
