#!/bin/bash

mkdir -p ~/Softwares

sudo pacman -S --noconfirm vim cmake aria2 xclip alacritty \
    a52dec faac faad2 flac jasper lame libdca neovim \
    libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 x265 \
    xvidcore p7zip util-linux libxcrypt libxcrypt-compat \
    mythes-en gst-plugins-good ttf-droid jdk17-openjdk icedtea-web \
    ttf-ubuntu-font-family ttf-anonymous-pro ufw \
    gst-libav libdvdnav fuse-exfat libvorbis rclone \
    libdvdcss lame libmpeg2 libtheora libxv libdvdread \
    gstreamer deja-dup ctags tree nload btop dbeaver \
    github-cli ncdu yt-dlp git-delta blueman lsof tmux \
    keepassxc code obsidian gedit svt-av1 bat starship \
    xfce4-clipman-plugin blueberry git-lfs arj bzip3 \
    lhasa lrzip openbsd-netcat pandoc glab

# Bluetooth
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# Network tools
sudo pacman -S --noconfirm traceroute nmap wireshark-qt

# Final manual steps
# set GRUB_TIMEOUT=0; GRUB_HIDDEN_TIMEOUT=0; GRUB_DEFAULT=saved
# then run `sudo grub-mkconfig -o /boot/grub/grub.cfg`

# Programming languages

# Python
sudo pacman -S --noconfirm python-virtualenv python-pip

sudo pacman -S python-numpy python-scipy python-matplotlib python-sympy \
    jupyterlab python-pandas python-pandas-datareader python-numexpr \
    python-bottleneck python-tabulate python-scikit-learn python-numba \
    python-tqdm python-joblib jupyterlab-lsp jupyterlab-widgets python-psycopg \
    python-psycopg-pool python-lsp-server texlab pyright python-plotly \
    python-ipywidgets python-colorcet python-pyarrow python-lz4 python-distributed \
    python-libarchive-c python-pygit2 python-smbprotocol python-snappy \
    python-hf-xet python-graphviz python-pydot python-openai python-tiktoken \
    python-llm python-websockets python-soundfile python-boto3 python-awscrt \
    python-uvloop python-httpx python-aiofiles python-redis python-hiredis \
    jupyterlab-lsp

yay -S python-blobfile python-google-genai python-anthropic
yay -S python-hf-transfer python-safetensors

sudo pacman -S python-pytorch-opt python-torchvision

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

sudo pacman -S --noconfirm postgresql

yay -S pg_activity

sudo pacman -S --noconfirm redis

# TODO: install TimescaleDB


## Setup Postgres

## Setup TimescaleDB

## Setup Redis

# Infrastructure Tools

# Docker
sudo pacman -S --noconfirm docker docker-compose docker-buildx
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker $(whoami)

mkdir -p ~/.docker
cp docker/config.json ~/.docker/config.json

# AWS CLI
sudo pacman -S --noconfirm aws-cli

# Google Cloud SDK
yay -S --noconfirm google-cloud-sdk

# K6
yay -S --noconfirm k6-bin

# Terraform
sudo pacman -S --noconfirm terraform

# Kubernetes (exclude the cluster running tools)
sudo pacman -S --noconfirm kubectl kubectx k9s

# Nomad
sudo pacman -S --noconfirm nomad consul

# Packer
sudo pacman -S --noconfirm packer

# Vagrant
sudo pacman -S --noconfirm vagrant

# Google Drive Client Insync
yay -S --noconfirm insync

# Below command is error prone, run manually
# yay -S --noconfirm lens

# Other developer tools

# phantomjs

yay -S --noconfirm phantomjs

# Slack
yay -S --noconfirm slack tar-desktop

# Tor Browser
sudo pacman -S --noconfirm torbrowser-launcher

# Postman
yay -S --noconfirm postman-bin

# Insomnia
yay -S --noconfirm insomnia

# Sioyek
yay -S --noconfirm sioyek

# Bloaty (Google): https://github.com/google/bloaty
yay -S --noconfirm bloaty

# "Normal" user software

sudo pacman -S --noconfirm libreoffice-fresh vlc chromium gparted gpart calibre

yay -S --noconfirm brave-bin

yay -S --noconfirm spotify

yay -S --noconfirm telegram-desktop

yay -S --noconfirm zoom

sudo pacman -S --noconfirm neomutt

# Audio/Video Software

sudo pacman -S --noconfirm ffmpeg mlt

# Image editing

sudo pacman -S --noconfirm gimp

# Video Editing

sudo pacman -S --noconfirm kdenlive breeze

yay -S --noconfirm alac-git

# Jet Brains IDEs
yay -S --noconfirm pycharm-professional

# AI IDEs and agents

yay -S claude-code cursor-bin openai-codex

# Notes
yay -S notes

# Timeshift (only with BTRFS)

sudo pacman -S --noconfirm timeshift
sudo systemctl enable --now cronie.service

# Extra browsers
yay -S google-chrome ungoogled-chromium

# Replicate
yay -S replicate-cog-bin

# Follow steps to setup snapshots in GRUB: https://discovery.endeavouros.com/encrypted-installation/btrfs-with-timeshift-snapshots-on-the-grub-menu/2022/02/

# Remove orphans
# sudo pacman -Rns $(pacman -Qtdq)

# Clear pacman cache
sudo pacman -Sc

# Battery improvement on suspend
# https://www.reddit.com/r/Ubuntu/comments/k24okb/battery_drain_on_laptop_while_suspended/

# HDD
# all new drives to /drives which has the permissions
# drwxr-xr-x 3 root root 4096 Jul 12 23:22 internalfirst2tb
# Cmd ref: chmod -R 777 /drives
# /etc/fstab entry
# <file system>             <mount point>  <type>  <options>  <dump>  <pass>
# UUID=9090-1059                            /efi           vfat    defaults,noatime 0 2
# UUID=51b25633-fa3b-421e-90a0-dc2c780711ea /              ext4    defaults,noatime 0 1
# tmpfs                                     /tmp           tmpfs   defaults,noatime,mode=1777 0 0
# UUID=4172e0dc-9232-4880-bca2-d72be1336aec /drives/internalfirst2tb ext4 defaults 0 0

# Setup Rclone

# GitHub CLI extensions
# https://github.com/joaom00/gh-b
gh extension install joaom00/gh-b

# https://github.com/dlvhdr/gh-dash
gh extension install dlvhdr/gh-dash

# https://github.com/yusukebe/gh-markdown-preview
gh extension install yusukebe/gh-markdown-preview

# https://github.com/thatvegandev/gh-eco
gh extension install thatvegandev/gh-eco

# https://github.com/k1LoW/gh-grep
gh extension install k1LoW/gh-grep

# https://github.com/gennaro-tedesco/gh-s
gh extension install gennaro-tedesco/gh-s

# https://github.com/gennaro-tedesco/gh-i
gh extension install gennaro-tedesco/gh-i

# https://github.com/meiji163/gh-notify
gh extension install meiji163/gh-notify

# https://github.com/heaths/gh-label
gh extension install heaths/gh-label

# Root backups

alias root_backup="sudo rsync -aHAXS --exclude={\"/dev/*\",\"/proc/*\",\"/sys/*\",\"/tmp/*\",\"/run/*\",\"/mnt/*\",\"/media/*\",\"/lost+found\",\"/drives/*\",\"/home/*\",\"/var/lib/ollama/.ollama/models/*\"} /* /drives/internalfirst2tb/RootBackup/"
alias root_restore="sudo rsync -aHAXS --exclude={\"/dev/*\",\"/proc/*\",\"/sys/*\",\"/tmp/*\",\"/run/*\",\"/mnt/*\",\"/media/*\",\"/lost+found\",\"/drives/*\",\"/home/*\",\"/var/lib/ollama/.ollama/models/*\"} /drives/internalfirst2tb/RootBackup/* /"


