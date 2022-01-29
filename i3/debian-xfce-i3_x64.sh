#!/bin/bash

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ "$(id -u)" != "0" ]; then
    echo " "
    echo "PLEASE RUN THIS SCRIPT AS ROOT OR SUDO"
    echo " "
    exit
fi

URL_MONOFONT="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.225/JetBrainsMono-2.225.zip"
URL_MONGODB_COMPASS="https://github.com/mongodb-js/compass/releases/download/v1.30.1/mongodb-compass_1.30.1_amd64.deb"

#########

echo " "
echo "INITIALIZE" && sleep 4
apt update -qq && apt install ca-certificates curl wget ssh unzip zip sudo net-tools nano pwgen fail2ban gnupg lsb-release -yqq

echo " "
echo "ADDING KEYS AND REPOSITORIES" && sleep 4
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | apt-key add -
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list

echo " "
echo "ADDING PACKAGES AND STUFF" && sleep 4
cd /tmp
wget -q $URL_MONGODB_COMPASS && apt install ./mongodb-compass_*_amd64.deb -yqq
wget -q $URL_MONOFONT && unzip -qqo JetBrainsMono*.zip && cp fonts/ttf/JetBrainsMono*.ttf /usr/share/fonts/
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt install ./google-chrome-stable_current_amd64.deb -yqq

# LATEST_MYSQL=$(curl -s https://dev.mysql.com/downloads/repo/apt/ | grep mysql-apt-config | cut -d'(' -f2 | cut -d')' -f1)
# wget -q https://dev.mysql.com/get/$LATEST_MYSQL && apt install ./mysql-apt-config_*_all.deb -yqq

LATEST_MONGODB_COMPASS=$(curl -s https://github.com/mongodb-js/compass/releases/latest | cut -d'"' -f2)
LATEST_MONGODB_COMPASS_VERSION=$(echo $LATEST_MONGODB_COMPASS | cut -d'/' -f8)
wget -q https://github.com/docker/compose/releases/download/$LATEST_DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64
mv docker-compose-Linux-x86_64 docker-compose && chmod 755 docker-compose

apt update -qq && apt install dbeaver-ce i3 ufw gufw gimp thunderbird gparted synaptic neofetch nitrogen libreoffice compton sqlite3 xfce4-appmenu-plugin libpcre3 \
    apache2 php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} libapache2-mod-php libsodium23 \
    imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 \
    openssl libapache2-mpm-itk libmagickcore-6.q16hdri-3-extra libmagickcore-6.q16-6-extra ffmpeg ghostscript \
    docker-ce docker-ce-cli containerd.io rofi spotify-client vlc stacer -yqq

echo " "
echo "DOWNLOADING WALLPAPER" && sleep 4
mkdir -p /usr/share/backgrounds
cd /usr/share/backgrounds

wget -q https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg
mv LEps6S.jpg linux-wallpaper-01.jpg
