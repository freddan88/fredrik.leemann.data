#!/usr/bin/env bash

url_google_chrome_browser="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
url_xfce_panel_profiles="http://mirrors.kernel.org/ubuntu/pool/universe/x/xfce4-panel-profiles/xfce4-panel-profiles_1.0.13-0ubuntu2_all.deb"
url_pulseaudio_ctl="https://github.com/graysky2/pulseaudio-ctl/archive/refs/tags/v1.70.zip"

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
echo "INSTALLING i3 SOFTWARE" && sleep 2
echo " "

apt update -qq
apt install curl wget git gzip bzip2 unzip zip tar lsb-release -y

apt install xorg i3 i3status picom rofi xinput lxappearance arandr pulseaudio pulseaudio-utils alsa-utils pavucontrol libnotify-bin -y
apt install playerctl xbacklight numlockx nano vim xterm screen members dbus-x11 w3m ssh zsh xss-lock htop pwgen openssl lshw ufw gufw nitrogen -y
apt install ftp tftp net-tools fail2ban dos2unix colord xiccd neofetch vlc samba make gcc build-essential minicom cutecom thunderbird bc pandoc -y
apt install arc-theme gnome-icon-theme lxde-icon-theme elementary-xfce-icon-theme thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman eject -y
apt install libpcre3 cpuid cpuidtool cpuinfo gthumb catfish mousepad ntfs-3g tftpd-hpa dosfstools exfatprogs cifs-utils nfs-common gvfs gvfs-backends gvfs-fuse -y
apt install ghostscript cmatrix xarchiver exo-utils ffmpeg gparted synaptic stacer gimp mirage typecatcher baobab util-linux onboard screenkey xdotool libreoffice -y

apt install xfce4-panel xfce4-appmenu-plugin xfce4-appfinder xfce4-terminal xfce4-screenshooter xfce4-power-manager xfce4-pulseaudio-plugin xfce4-battery-plugin --no-install-recommends -y
apt install policykit-1-gnome gnome-software gnome-system-monitor gnome-calendar network-manager-gnome network-manager-openvpn gnome-disk-utility --no-install-recommends -y

apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.spotify.Client --noninteractive -y

if [ $(lsb_release -is) = "Debian" ]; then
  ln -s /sbin/ifconfig /usr/bin/ifconfig
  apt install debian-edu-artwork libavcodec-extra unrar ttf-mscorefonts-installer gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi -y
  cd /tmp && wget $url_xfce_panel_profiles && apt install ./xfce4-panel-profiles*.deb -y
  cd /tmp && rm -f xfce4-panel-profiles*.deb
fi

if [ $(lsb_release -is) = "Ubuntu" ]; then
  add-apt-repository multiverse
  apt install ubuntu-restricted-extras -y
fi

if [ ! -f "$(command -v google-chrome)" ]; then
  cd /tmp && wget $url_google_chrome_browser && apt install ./google-chrome-stable_current_amd64.deb -y
  cd /tmp && rm -f google-chrome-stable_current_amd64.deb
fi

if [ ! -f "/usr/bin/pulseaudio-ctl" ]; then
  cd /tmp && wget -O pulseaudio-ctl.zip $url_pulseaudio_ctl && unzip -o pulseaudio-ctl.zip
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

chown -R tftp:nogroup /srv/tftp 2>/dev/null
apt autoremove -y && apt update

echo " "
echo "DONE!"
echo " "
