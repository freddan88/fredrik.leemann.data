#!/bin/sh

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ "$(id -u)" != "0" ]; then
	echo " "
		echo "PLEASE RUN THIS SCRIPT AS ROOT OR SUDO"
	echo " "
	exit
fi

##############################################

echo " "
    echo "INITIALIZE" && sleep 2
    apt install apt-transport-https ca-certificates gnupg-agent software-properties-common -y
echo " "

echo " "
    echo "ADDING GBG-KEYS TO SYSTEM" && sleep 2
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
echo " "

echo " "
    echo "ADDING PERSONAL PACKAGE ARCHIVES" && sleep 2
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    add-apt-repository ppa:linuxgndu/sqlitebrowser
    add-apt-repository ppa:serge-rider/dbeaver-ce
    add-apt-repository ppa:regolith-linux/stable
    sudo apt-get update
echo " "

echo " "
    echo "INSTALLING SOFTWARE" && sleep 2
    apt-get install sqlitebrowser dbeaver-ce i3-wm zsh ssh zip sudo ufw gufw net-tools gimp thunderbird gparted synaptic neofetch nitrogen imagemagick libreoffice \
    compton arc-theme ayu-theme sqlite3 ubuntu-restricted-extras gnome-icon-theme xfce4-appmenu-plugin flatpak snapd nano git apache2 libsodium23 libpcre3 pwgen \
    php php-{bcmath,cli,common,curl,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip} libapache2-mod-php php-common php-imagick php-pear php-cgi php-phpseclib \
    imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 \
    openssl libapache2-mpm-itk libmagickcore-6.q16hdri-3-extra libmagickcore-6.q16-6-extra ffmpeg ghostscript net-tools docker-ce docker-ce-cli containerd.io \
    fonts-ubuntu-font-family-console ttf-ubuntu-font-family python3 python3-pip build-essential libssl-dev libffi-dev python3-dev mysql-server mysql-client \
    mysql-workbench-community libmysqlclient21 curl wget -y

    snap install code --classic
    snap install spotify postman insomnia
    
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub com.github.alecaddd.sequeler
echo " "

echo " "
    echo "DOWNLOADING WALLPAPER" && sleep 2
    cd /usr/share/backgrounds
    wget -q https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg
    mv LEps6S.jpg linux-wallpaper-01.jpg
echo " "

echo " "
    echo "DOWNLOADING PACKAGES" && sleep 2
    LATEST_MYSQL=$(curl -s https://dev.mysql.com/downloads/repo/apt/ | grep mysql-apt-config | cut -d'(' -f2 | cut -d')' -f1)
    cd /tmp && wget -q https://dev.mysql.com/get/$LATEST_MYSQL && apt install ./mysql-apt-config_*_all.deb -y

    LATEST_COMPASS=$(curl -s https://github.com/mongodb-js/compass/releases/latest | cut -d'/' -f8 | cut -d'"' -f1)
    cd /tmp && wget -q https://github.com/mongodb-js/compass/releases/download/$LATEST_COMPASS/mongodb-compass_$(echo $LATEST_COMPASS)_amd64.deb
    cd /tmp && apt install ./mongodb-compass_*_amd64.deb -y

    LATEST_MONOFONT=$(curl -s https://github.com/JetBrains/JetBrainsMono/releases/latest | cut -d'"' -f2)
    LATEST_MONOTAG=$(echo $LATEST_MONOFONT | cut -d'/' -f8)
    cd /tmp && wget -q $LATEST_MONOFONT/JetBrainsMono-$LATEST_MONOTAG.zip
    cd /tmp && unzip JetBrainsMono-$LATEST_MONOTAG.zip && cd JetBrainsMono-$LATEST_MONOTAG
    cp JetBrainsMono-*.ttf /usr/share/fonts/

    cd /tmp && wget https://getcomposer.org/installer && chmod 755 installer
    php ./installer && mv composer.phar /usr/local/bin/composer

    cd /tmp && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    cd /tmp && apt install ./google-chrome-stable_current_amd64.deb -y

    LATEST_COMPOSE=$(curl -s https://github.com/docker/compose/releases/latest | cut -d'"' -f2)
    cd /usr/bin && -q wget ${LATEST_COMPOSE/tag/download}/docker-compose-$(uname -s)-$(uname -m)
    cd /usr/bin && mv docker-compose-$(uname -s)-$(uname -m) docker-compose && chmod 755 docker-compose
echo " "

exit