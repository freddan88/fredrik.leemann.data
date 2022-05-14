#!/usr/bin/env bash

url_linux_wallpaper="https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg"
url_google_chrome_browser="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
url_xfce_panel_profiles="http://mirrors.kernel.org/ubuntu/pool/universe/x/xfce4-panel-profiles/xfce4-panel-profiles_1.0.13-0ubuntu2_all.deb"
url_latest_pulseaudio_ctl="https://github.com/graysky2/pulseaudio-ctl/archive/refs/tags/v1.70.zip"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ ! "$SUDO_USER" ] || [ "$SUDO_USER" = "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

echo " "
echo "INITIALIZE" && sleep 2
echo " "
apt update -qq && apt install dbus-x11 lsb-release curl wget git w3m gzip bzip2 unzip zip tar ssh zsh xss-lock cups system-config-printer gnome-disk-utility openssl -y
apt install htop pwgen ftp tftp picom rofi screen xterm members net-tools playerctl xbacklight numlockx nano vim fail2ban dos2unix vlc colord xiccd neofetch spice-vdagent -y
apt install ghostscript cmatrix xarchiver exo-utils ufw gufw minicom ffmpeg cutecom gparted synaptic stacer gimp mirage typecatcher baobab samba util-linux onboard screenkey -y
apt install libpcre3 cpuid cpuidtool cpuinfo lshw pandoc gthumb catfish network-manager-openvpn nitrogen mousepad ntfs-3g exfat-utils tftpd-hpa dosfstools cifs-utils nfs-common -y
apt install xfce4-appfinder xfce4-terminal xfce4-screenshooter policykit-1-gnome gnome-software gnome-system-monitor gnome-calendar network-manager-gnome gnome-disk-utility --no-install-recommends -y
apt install arc-theme gnome-icon-theme lxde-icon-theme elementary-xfce-icon-theme thunderbird libreoffice thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman -y

apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.spotify.Client --noninteractive -y

if [ $(lsb_release -is) = "Debian" ]; then
  # Link ifconfig to another path so we don´t need sudo to execute it
  ln -s /sbin/ifconfig /usr/bin/ifconfigs
  apt install debian-edu-artwork libavcodec-extra ttf-mscorefonts-installer unrar gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi -y
fi

if [ $(lsb_release -is) = "Ubuntu" ]; then
  add-apt-repository multiverse
  apt install ubuntu-restricted-extras -y
fi

apt autoremove -y && apt update

chown -R tftp:nogroup /srv/tftp 2>/dev/null

if [ ! -f "$(command -v google-chrome)" ]; then
  cd /tmp && wget $url_google_chrome_browser && apt install ./google-chrome-stable_current_amd64.deb -y
  cd /tmp && rm -f google-chrome-stable_current_amd64.deb
fi

if [ ! -f "/usr/share/wallpapers/linux-wallpaper-01.jpg" ]; then
  cd /tmp && mkdir -p /usr/share/wallpapers
  # Download and add linux-penguin wallpaper from wallpapersafari.com
  cd /tmp && wget $url_linux_wallpaper && mv -f LEps6S.jpg /usr/share/wallpapers/linux-wallpaper-01.jpg
fi

if [ ! -f "/usr/bin/pulseaudio-ctl" ]; then
  cd /tmp && wget -O pulseaudio-ctl.zip $url_latest_pulseaudio_ctl && unzip -o pulseaudio-ctl.zip
  cd /tmp && cd pulseaudio-ctl-* && make install && cd /tmp && rm -rf pulseaudio-ctl*
fi

echo " "
echo "DISABLING SAMBA FILE SHARE FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
echo " "
systemctl disable smbd.service
systemctl disable nmbd.service
systemctl stop smbd.service
systemctl stop nmbd.service

echo " "
echo "DISABLING TFTP-SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
echo " "
systemctl disable tftpd-hpa.service
systemctl stop tftpd-hpa.service

echo " "
echo "DONE!"
echo " "
