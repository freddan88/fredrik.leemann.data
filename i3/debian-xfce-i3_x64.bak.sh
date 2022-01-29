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

############
case "$1" in

update_i3 () {
echo " "
    echo "UPDATING I3 CONFIGURATION" && sleep 4
    I3_CONFIG=$(curl -s https://raw.githubusercontent.com/freddan88/xubuntu-i3wm/main/configurations/i3-config.txt)
    echo $I3_CONFIG > $HOME/.config/i3/config
}

update_zsh () {
echo " "
    echo "UPDATING ZSH CONFIGURATION" && sleep 4
    ZSH_CONFIG=$(curl -s https://raw.githubusercontent.com/freddan88/xubuntu-i3wm/main/configurations/zshrc.txt)
    echo $ZSH_CONFIG > $HOME/.zshrc
}

install)
echo " "
    echo "INITIALIZE" && sleep 4
    apt install apt-transport-https ca-certificates curl wget gnupg-agent software-properties-common lsb-release -yqq

echo " "
    echo "ADDING KEYS TO SYSTEM" && sleep 4
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
    wget -O - -q http://deb.tableplus.com/apt.tableplus.com.gpg.key | sudo apt-key add -

echo " "
    echo "ADDING PERSONAL PACKAGE ARCHIVES" && sleep 4
    # sed "s/v//g" <<< "v2.225"

    LATEST_MYSQL=$(curl -s https://dev.mysql.com/downloads/repo/apt/ | grep mysql-apt-config | cut -d'(' -f2 | cut -d')' -f1)
    wget -q https://dev.mysql.com/get/$LATEST_MYSQL && apt install ./mysql-apt-config_*_all.deb -yqq

    URL_MONOFONT="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.225/JetBrainsMono-2.225.zip"
    wget -q $URL_MONOFONT && unzip -qqo JetBrainsMono*.zip && cp fonts/ttf/JetBrainsMono*.ttf /usr/share/fonts/

    URL_MONGODB_COMPASS="https://github.com/mongodb-js/compass/releases/download/v1.26.0/mongodb-compass_1.26.0_amd64.deb"
    wget -q $URL_MONGODB_COMPASS && apt install ./mongodb-compass_*_amd64.deb -yqq

    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install ./google-chrome-stable_current_amd64.deb -yqq

    LATEST_COMPOSE=$(curl -s https://github.com/docker/compose/releases/latest | cut -d'"' -f2)
    LATEST_VERSION=$(echo $LATEST_COMPOSE | cut -d'/' -f8)

    wget -q https://github.com/docker/compose/releases/download/$LATEST_VERSION/docker-compose-Linux-x86_64
    mv docker-compose-Linux-x86_64 docker-compose && chmod 755 docker-compose

    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    add-apt-repository "deb [arch=amd64] https://deb.tableplus.com/debian tableplus main" -yn
    sudo add-apt-repository ppa:oguzhaninan/stacer -yn
    add-apt-repository ppa:linuxgndu/sqlitebrowser -yn
    add-apt-repository ppa:serge-rider/dbeaver-ce -yn
    add-apt-repository ppa:regolith-linux/stable -yn
    apt-get update -qq

echo " "
    echo "INSTALLING SOFTWARE" && sleep 4
    apt-get install sqlitebrowser dbeaver-ce i3-wm ssh zip sudo ufw gufw net-tools gimp thunderbird gparted synaptic neofetch nitrogen libreoffice curl wget \
    compton arc-theme ayu-theme sqlite3 ubuntu-restricted-extras gnome-icon-theme xfce4-appmenu-plugin flatpak snapd nano apache2 libsodium23 libpcre3 pwgen \
    php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} libapache2-mod-php unzip zip \
    imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 \
    openssl libapache2-mpm-itk libmagickcore-6.q16hdri-3-extra libmagickcore-6.q16-6-extra ffmpeg ghostscript net-tools docker-ce docker-ce-cli containerd.io \
    fonts-ubuntu-font-family-console ttf-ubuntu-font-family python3 python3-pip build-essential libssl-dev libffi-dev python3-dev fail2ban gedit rofi \
    mysql-server mysql-client mysql-workbench-community libmysqlclient21 spotify-client tableplus vlc stacer -yqq

    wget -q https://getcomposer.org/installer && chmod 755 installer
    php ./installer && mv composer.phar /usr/local/bin/composer

    snap install postman insomnia
    snap install code --classic
    
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub com.github.alecaddd.sequeler

    apt update -qq && apt upgrade -yqq && apt autoremove -yqq

echo " "
    echo "DOWNLOADING WALLPAPER" && sleep 4
    cd /usr/share/backgrounds

    wget -q https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg
    mv LEps6S.jpg linux-wallpaper-01.jpg

echo " "
    usermod -aG docker $USERNAME
    update_zsh
    update_i3
echo " "
;;

update_i3-config)
    update_i3
echo " "
;;

update_zsh-config)
    update_zsh
echo " "
;;

update_all-configs)
    update_zsh
    update_i3
echo " "
;;

*)
echo " "
	echo "Usage: install|update_i3-config|update_zsh-config|update_all-configs"
echo " "
;;

esac
exit