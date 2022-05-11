#!/usr/bin/env bash

url_zsh_config="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/shell/zshrc.txt"
url_i3_config="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/config-i3-xfce-v3.txt"
url_i3status_config="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/config_i3status"
url_mongodb_compass="https://github.com/mongodb-js/compass/releases/download/v1.30.1/mongodb-compass_1.30.1_amd64.deb"
url_jetbrains_mono_fonts="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip"
url_google_fonts="https://github.com/google/fonts/archive/main.tar.gz"
url_linux_wallpaper="https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg"
url_google_chrome_browser="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

function check_sudo_user() {
  if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
    echo " "
    echo "PLEASE RUN THIS COMMAND AS A SUDO-USER"
    echo " "
    exit
  fi
}

function software_install() {

  echo " "
  echo "INITIALIZE" && sleep 2
  apt update -qq && apt install lsb-release curl wget git gzip bzip2 unzip zip tar ssh -y

  echo " "
  echo "INSTALLING FONTS" && sleep 2
  apt install fonts-cascadia-code fonts-cantarell -y
  cd /tmp && wget -q $url_jetbrains_mono_fonts && unzip -qqo JetBrainsMono*.zip
  cd /tmp && mkdir -p /usr/share/fonts/truetype/jetbrains-mono
  cd /tmp && find $PWD/fonts/ttf/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/jetbrains-mono/ \;
  cd /tmp && wget -q $url_google_fonts && tar -zxvf main.tar.gz
  cd /tmp && mkdir -p /usr/share/fonts/truetype/google-fonts
  cd /tmp && find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \;
  cd /tmp && rm -rf fonts* JetBrainsMono*.zip main.tar.gz && fc-cache -f

  echo " "
  echo "INSTALLING ESSENTIAL SOFTWARE" && sleep 2
  apt install xorg i3 i3status slim sudo picom rofi playerctl xbacklight numlockx lxappearance arandr nitrogen pulseaudio alsa-utils pavucontrol net-tools htop lshw util-linux -y
  apt install ufw gufw openssl pwgen nano vim screen members xarchiver ffmpeg vlc gparted synaptic stacer mirage gimp baobab xterm cmatrix neofetch ftp tftp dos2unix mousepad -y
  apt install arc-theme gnome-icon-theme lxde-icon-theme elementary-xfce-icon-theme debian-edu-artwork exo-utils samba cifs-utils nfs-common dosfstools ntfs-3g exfat-utils -y
  apt install xfce4-appfinder xfce4-terminal xfce4-screenshooter policykit-1-gnome gnome-software gnome-system-monitor gnome-calendar network-manager-gnome gnome-disk-utility --no-install-recommends -y
  apt install thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman network-manager-openvpn gvfs gvfs-backends gvfs-fuse gthumb -y

  apt install flatpak gnome-software-plugin-flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub com.spotify.Client --noninteractive -y

  chown -R tftp:nogroup /srv/tftp 2>/dev/null
  cd /tmp && wget -q $url_google_chrome_browser && apt install ./google-chrome-stable_current_amd64.deb -y
  cd /tmp && rm -f google-chrome-stable_current_amd64.deb

  # Download and add linux-penguin wallpaper from wallpapersafari.com
  cd /tmp && mkdir -p /usr/share/wallpapers
  cd /tmp && wget -q $url_linux_wallpaper && mv -f LEps6S.jpg /usr/share/wallpapers/linux-wallpaper-01.jpg

  echo " "
  echo "DISABLING SAMBA FILE SHARE FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
  systemctl disable smbd.service
  systemctl disable nmbd.service
  systemctl stop smbd.service
  systemctl stop nmbd.service

  echo " "
  echo "DISABLING TFTP-SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
  systemctl disable tftpd-hpa.service
  systemctl stop tftpd-hpa.service
}

check_sudo_user
software_install
