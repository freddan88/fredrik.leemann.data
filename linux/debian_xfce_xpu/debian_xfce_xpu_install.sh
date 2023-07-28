#!/usr/bin/env bash

# https://design.ubuntu.com/font
# https://github.com/microsoft/cascadia-code/releases
# https://www.mongodb.com/docs/compass/master/install

url_mongo_db_compass="https://downloads.mongodb.com/compass/mongodb-compass_1.39.0_amd64.deb"
url_fonts_cascadia_code="https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip"
url_fonts_ubuntu="https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip"

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
echo "INSTALLING SOFTWARE" && sleep 2
echo " "

# sudo apt install ssh zsh git curl wget tar zip unzip 7zip p7zip-full xzip fastjar lrzip gzip bzip2 bzip3 nano vim ca-certificates software-properties-common gnupg nala -y

# Debian-packages from the non-free repos (contrib non-free):
apt-add-repository contrib non-free -y
apt install ttf-mscorefonts-installer unrar -y
apt update && apt upgrade -y

apt install xfce4 xfce4-goodies xfce4-panel-profiles slick-greeter lightdm-settings numlockx xinput xdotool wmctrl rofi screen members neofetch pwgen htop w3m -y
apt install cpuid cpuidtool cpuinfo lshw ghostscript v4l-utils fzf jq net-tools fail2ban cmatrix screenkey orca onboard minicom cutecom pandoc powertop lrzsz -y
apt install ntfs-3g dosfstools exfatprogs dos2unix cifs-utils smbclient samba nfs-common ftp tftp tftpd-hpa mariadb-client gparted stacer catfish perl baobab -y
apt install arc-theme gnome-icon-theme elementary-xfce-icon-theme gnome-system-monitor gnome-disk-utility network-manager* remmina synaptic snapd -y
apt install ufw gufw gimp vlc pitivi simplescreenrecorder obs-studio libreoffice mousepad thunderbird galculator imagemagick mugshot exiftool -y
apt install ffmpeg libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi openssl libpcre3 -y

ln -s /etc/profile.d/apps-bin-path.sh /etc/X11/Xsession.d/99snap

# snap install core
# snap install core20
snap install spotify

if [ ! -f "$(command -v google-chrome)" ]; then
  cd /tmp && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  apt install ./google-chrome-stable_current_amd64.deb -y
  rm -f google-chrome-stable_current_amd64.deb
fi

if [ ! -d "/usr/share/fonts/truetype/cascadia-code" ]; then
  mkdir /tmp/cascadia-code && cd /tmp/cascadia-code || exit
  wget $url_fonts_cascadia_code && unzip CascadiaCode-*.zip
  mkdir -p /usr/share/fonts/truetype/cascadia-code && cd /tmp/cascadia-code/ttf || exit
  find . -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/cascadia-code \;
  rm -rf cascadia-code
fi

if [ ! -d "/usr/share/fonts/truetype/ubuntu-font-family" ]; then
  cd /tmp && wget $url_fonts_ubuntu -O ubuntu-font-family.zip && unzip ubuntu-font-family.zip
  mkdir -p /usr/share/fonts/truetype/ubuntu-font-family && cd /tmp/ubuntu-font-family-* || exit
  find . -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/ubuntu-font-family \;
  rm -rf __MACOSX ubuntu-font-family*
fi

cd "/home/$SUDO_USER" || exit
wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/debian_xfce_xpu/debian_xfce_xpu_home.zip
unzip -oq debian_xfce_xpu_home.zip
rm -f debian_xfce_xpu_home.zip

chown -R "$SUDO_USER:$SUDO_USER" .configs

# apt install sqlite3

snap install insomnia
snap install dbeaver-ce
snap install sqlitebrowser
snap install mysql-workbench-community

if [ ! -f "$(command -v mongodb-compass)" ]; then
  cd /tmp && wget $url_mongo_db_compass
  apt install ./mongodb-compass*amd64.deb -y
  rm -f mongodb-compass*amd64.deb
fi

if [ -f "/etc/network/interfaces" ]; then
  mv /etc/network/interfaces /etc/network/interfaces.bak
fi

cd /
wget https://github.com/freddan88/fredrik.leemann.data/raw/main/linux/debian_xfce_xpu/debian_xfce_xpu_root.zip
unzip -oq debian_xfce_xpu_root.zip
rm -f debian_xfce_xpu_root.zip

echo " "
echo "DONE"
echo " "

# chromium-codecs-ffmpeg-extra // Unable to locate package
#
# apt install <package> --dry-run
# apt install cpufreqd cpufrequtils acpi cpulimit
# apt install make gcc build-essential linux-headers-$(uname-r)
#
# open file /etc/login.defs // Not needed
# add in line ENV_PATH PATH= ?
# /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
# it should be: ?
# ENV_PATH PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
# Logout and login again, try to install some snap app