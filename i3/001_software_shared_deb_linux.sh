#!/usr/bin/env bash

url_linux_wallpaper="https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg"
url_google_chrome_browser="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

echo " "
echo "INITIALIZE" && sleep 2
echo " "
apt update -qq && apt install dbus-x11 lsb-release curl wget git w3m gzip bzip2 unzip zip tar ssh zsh xss-lock cups system-config-printer -y
apt install htop pwgen ftp tftp sudo picom rofi screen xterm members net-tools playerctl xbacklight numlockx nano vim fail2ban dos2unix vlc colord xiccd neofetch -y
apt install ghostscript cmatrix xarchiver exo-utils ufw gufw minicom ffmpeg cutecom gparted synaptic stacer gimp mirage typecatcher baobab samba util-linux onboard screenkey openssl -y
apt install libpcre3 cpuid cpuidtool cpuinfo lshw pandoc gthumb catfish network-manager-openvpn nitrogen mousepad ntfs-3g exfat-utils tftpd-hpa dosfstools cifs-utils nfs-common spice-vdagent -y
apt install xfce4-appfinder xfce4-terminal xfce4-screenshooter policykit-1-gnome gnome-software gnome-system-monitor gnome-calendar network-manager-gnome gnome-disk-utility --no-install-recommends -y
apt install arc-theme gnome-icon-theme lxde-icon-theme elementary-xfce-icon-theme thunderbird libreoffice thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman -y

apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.spotify.Client --noninteractive -y

chown -R tftp:nogroup /srv/tftp 2>/dev/null
cd /tmp && wget $url_google_chrome_browser && apt install ./google-chrome-stable_current_amd64.deb -y
cd /tmp && rm -f google-chrome-stable_current_amd64.deb

# Download and add linux-penguin wallpaper from wallpapersafari.com
cd /tmp && mkdir -p /usr/share/wallpapers
cd /tmp && wget $url_linux_wallpaper && mv -f LEps6S.jpg /usr/share/wallpapers/linux-wallpaper-01.jpg

# Link ifconfig to another path so we don´t need sudo to execute it
sudo ln -fs /sbin/ifconfig /bin/ifconfig

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
