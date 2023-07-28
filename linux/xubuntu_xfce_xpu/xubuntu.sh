#!/usr/bin/env bash

# Download-url from: https://www.mongodb.com/try/download/compass
url_mongo_db_compass="https://downloads.mongodb.com/compass/mongodb-compass_1.39.0_amd64.deb"
url_google_chrome_browser="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
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
echo "INSTALLING SOFTWARE" && sleep 2
echo " "

apt install git wget curl zip unzip tar gzip bzip2 bzip3 ssh zsh nano vim nala -y
apt install rofi dos2unix cpuid cpuidtool cpuinfo screen members neofetch w3m xinput numlockx libpcre3 htop pwgen openssl lshw ghostscript imagemagick -y
apt install ntfs-3g mtools dosfstools exfatprogs cifs-utils smbclient samba nfs-common vlc v4l-utils fzf net-tools fail2ban cmatrix htop xarchiver -y
apt install arc-theme gnome-icon-theme elementary-xfce-icon-theme screenkey orca ufw gufw minicom cutecom pandoc powertop ftp tftp tftpd-hpa -y
apt install ffmpeg gparted synaptic stacer gimp baobab xdotool libreoffice mousepad galculator pitivi simplescreenrecorder obs-studio -y
apt install gnome-system-monitor gnome-calendar network-manager-openvpn gnome-disk-utility mysql-client ca-certificates gnupg -y
apt install xfce4-screenshooter xfce4-battery-plugin xfce4-appmenu-plugin thunderbird -y

snap install spotify

# apt-get install <package> --dry-run
# cpufreqd cpufrequtils acpi cpulimit
# make gcc build-essential

if [ ! -f "$(command -v google-chrome)" ]; then
    cd /tmp && wget $url_google_chrome_browser && apt install ./google-chrome-stable_current_amd64.deb -y
    cd /tmp && rm -f google-chrome-stable_current_amd64.deb
fi

if [ ! -f "$(command -v deb-get)" ]; then
    cd /tmp && curl -sL $url_latest_deb_get | bash -s install deb-get
fi

if [ ! -f "$(command -v mongodb-compass)" ]; then
    cd /tmp && wget $url_mongo_db_compass && apt install ./mongodb-compass*amd64.deb -y
    cd /tmp && rm -f mongodb-compass*amd64.deb
fi

snap install insomnia dbeaver-ce mysql-workbench-community sqlitebrowser

echo " "
echo "DONE"
echo " "

# INSTALL RESTRICTED EXTRAS
# ubuntu-restricted-extras

# PANEL-COLOR
# #383C4A
