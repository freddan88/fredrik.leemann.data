#!/usr/bin/env bash

url_google_chrome_browser="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
url_xfce_panel_profiles="http://ftp.ports.debian.org/debian-ports/pool/main/x/xfce4-panel-profiles/xfce4-panel-profiles_1.0.13-1.1_all.deb"
url_pulseaudio_ctl="https://github.com/graysky2/pulseaudio-ctl/archive/refs/tags/v1.70.zip"
url_grub_minimal_config="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/bootloaders/minimal-grub.cfg"
url_lightdm_slick_config="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/display_managers/lightdm/slick-greeter.conf"
url_lightdm_config="https://raw.githubusercontent.com/freddan88/fredrik.leemann.data/main/linux/configurations/display_managers/lightdm/lightdm.conf"
url_latest_deb_get="https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get"

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
echo "INSTALLING MINIMAL SOFTWARE" && sleep 2
echo " "

apt update -qq
apt install curl wget git gzip bzip2 unzip zip tar lsb-release -y

apt install xorg xbacklight xbindkeys xvkbd xinput numlockx dbus-x11 picom rofi i3 i3status lxappearance arandr pulseaudio pulseaudio-utils alsa-utils pavucontrol libnotify-bin -y
apt install libpcre3 cpuid cpuidtool cpuinfo gthumb catfish mousepad ntfs-3g mtools dosfstools exfatprogs cifs-utils nfs-common gvfs gvfs-backends gvfs-fuse nano vim -y
apt install arc-theme gnome-icon-theme lxde-icon-theme elementary-xfce-icon-theme thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman eject thunderbird -y
apt install ghostscript cmatrix xarchiver exo-utils ffmpeg gparted synaptic stacer gimp mirage baobab util-linux onboard screenkey xdotool libreoffice cpufreqd samba -y
apt install playerctl xterm screen members w3m ssh zsh xss-lock htop pwgen openssl lshw ufw gufw nitrogen wmctrl dos2unix colord orca vlc fzf xiccd avahi-daemon bc -y
apt install ftp tftp tftpd-hpa net-tools fail2ban neofetch make gcc build-essential minicom cutecom pandoc network-manager appmenu-gtk2-module appmenu-gtk3-module -y
apt install lightdm slick-greeter lightdm-settings dunst v4l-utils acpi-support acpid acpi linux-cpupower cpufrequtils powertop cpulimit policykit-1-gnome -y

apt install xfce4-panel xfce4-appfinder xfce4-terminal xfce4-screenshooter xfce4-power-manager --no-install-recommends -y
apt install xfce4-appmenu-plugin xfce4-cpufreq-plugin xfce4-pulseaudio-plugin xfce4-battery-plugin --no-install-recommends -y
apt install gnome-software gnome-system-monitor gnome-calendar network-manager-gnome network-manager-openvpn gnome-disk-utility --no-install-recommends -y

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
sudo apt remove make gcc build-essential -y

echo " "
echo "DISABLING SAMBA FILE SHARE FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable smbd.service
systemctl disable nmbd.service
systemctl stop smbd.service
systemctl stop nmbd.service

echo " "
echo "DISABLING TFTP-SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS" && sleep 2
echo " "

systemctl disable tftpd-hpa.service
systemctl stop tftpd-hpa.service

chown -R tftp:nogroup /srv/tftp 2>/dev/null

echo " "
echo "DOWNLOADING AND INSTALLING LATEST DEB-GET FROM GITHUB" && sleep 2
echo " "

curl -sL $url_latest_deb_get | bash -s install deb-get

echo " "
echo "DOWNLOADING CONFIGURATIONS FOR LIGHTDM LOGIN MANAGER" && sleep 2
echo " "

cd /etc/lightdm && wget -O lightdm.conf $url_lightdm_config
cd /etc/lightdm && wget -O slick-greeter.conf $url_lightdm_slick_config

echo " "
echo "DOWNLOADING CONFIGURATION FOR GRUB BOOTLOADER" && sleep 2
echo " "

cd /etc/default || exit
wget -O grub $url_grub_minimal_config
/usr/sbin/update-grub

echo " "
echo "DONE!"
echo " "
