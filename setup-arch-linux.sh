sudo pacman -S --noconfirm vim cmake aria2 \
    a52dec faac faad2 flac jasper lame libdca \
    libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 \
    xvidcore gstreamer0.10-plugins vlc p7zip p7zip-plugins update-grub \
    mythes-en gst-plugins-good ttf-droid jdk11-openjdk icedtea-web \
    ttf-ubuntu-font-family ttf-anonymous-pro ufw \
    wavpack libdv libmad gst-libav libdvdnav fuse-exfat libvorbis faac \
    libdvdcss lame libmpeg2 libtheora libxv libdvdread exfat-utils \
    a52dec faad2 flac jasper gstreamer chromium visual-studio-code \
    deja-dup

# Final manual steps
# set GRUB_TIMEOUT=0; GRUB_HIDDEN_TIMEOUT=0; GRUB_DEFAULT=saved
# then run `sudo update-grub`

# Remove orphans
sudo pacman -Rns $(pacman -Qtdq)

sudo pacman-optimize

