#!/bin/bash

URL_MINT_THEME="http://packages.linuxmint.com/pool/main/m/mint-y-theme/mint-y-theme_1.2.3_all.deb"
URL_MINT_ICONS="http://packages.linuxmint.com/pool/main/m/mint-y-icons/mint-y-icons_1.5.9_all.deb"
URL_MONGODB_COMPASS="https://github.com/mongodb-js/compass/releases/download/v1.30.1/mongodb-compass_1.30.1_amd64.deb"
URL_JETBRAINS_MONOFONT="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ -z "$SUDO_USER" ]; then
    echo " "
    echo "PLEASE RUN THIS SCRIPT AS SUDO"
    echo " "
    exit
fi

SUDO_USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

get_i3_config() {
    echo " "
    echo "UPDATING i3 CONFIG" && sleep 4
    I3_CONFIG=$(curl -s https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/config-i3-xfce.txt)
    echo $I3_CONFIG >$SUDO_USER_HOME/.config/i3/config
    echo " "
    echo "DONE"
}

get_zsh_config() {
    echo " "
    echo "UPDATING ZSH CONFIG" && sleep 4
    ZSH_CONFIG=$(curl -s https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/shell/zshrc.txt)
    echo $ZSH_CONFIG >$SUDO_USER_HOME/.zshrc
    echo " "
    echo "DONE"
}

get_php_composer() {
    echo " "
    echo "UPDATING PHP COMPOSER" && sleep 4
    rm -f /usr/local/bin/composer
    wget -q https://getcomposer.org/installer && php ./installer
    mv composer.phar /usr/local/bin/composer && chmod 755 /usr/local/bin/composer
    echo " "
    echo "DONE"
}

get_docker_compose() {
    echo " "
    echo "UPDATING DOCKER COMPOSE" && sleep 4
    rm -f /usr/local/bin/docker-compose
    LATEST_DOCKER_COMPOSE=$(curl -s https://github.com/docker/compose/releases/latest | cut -d'"' -f2)
    LATEST_DOCKER_COMPOSE_VERSION=$(echo $LATEST_DOCKER_COMPOSE | cut -d'/' -f8)
    wget -q https://github.com/docker/compose/releases/download/$LATEST_DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64
    mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose && chmod 755 /usr/local/bin/docker-compose
    echo " "
    echo "DONE"
}

install_all() {
    echo " "
    echo "INITIALIZE" && sleep 4
    apt update -qq && apt install ca-certificates ssh zsh git unzip zip curl net-tools nano pwgen fail2ban gnupg lsb-release -yqq

    echo " "
    echo "ADDING KEYS AND REPOSITORIES" && sleep 4
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null

    curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list

    echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | tee -a /etc/apt/sources.list.d/insomnia.list

    echo " "
    echo "ADDING PACKAGES AND STUFF" && sleep 4
    cd /tmp
    wget -q $URL_MONGODB_COMPASS && apt install ./mongodb-compass_*_amd64.deb -yqq
    wget -q $URL_JETBRAINS_MONOFONT && unzip -qqo JetBrainsMono*.zip && cp fonts/ttf/JetBrainsMono*.ttf /usr/share/fonts/
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt install ./google-chrome-stable_current_amd64.deb -yqq

    # LATEST_MYSQL=$(curl -s https://dev.mysql.com/downloads/repo/apt/ | grep mysql-apt-config | cut -d'(' -f2 | cut -d')' -f1)
    # wget -q https://dev.mysql.com/get/$LATEST_MYSQL && apt install ./mysql-apt-config_*_all.deb -yqq

    URL_LATEST_VSCODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    wget -q $URL_LATEST_VSCODE
    apt install code_*_amd64.deb

    wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
    apt install ./dbeaver-ce_*_amd64.deb

    wget $URL_MINT_THEME
    wget $URL_MINT_ICONS
    apt install ./mint-y-icons_*_all.deb ./mint-y-theme_*_all.deb -y

    apt update -qq && apt install i3 ufw gufw gimp thunderbird gparted synaptic neofetch nitrogen libreoffice compton sqlite3 libpcre3 libsodium23 insomnia \
        apache2 php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} libapache2-mod-php \
        imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 \
        openssl libapache2-mpm-itk libmagickcore-6.q16hdri-3-extra libmagickcore-6.q16-6-extra ffmpeg ghostscript xfce4-screenshooter xfce4-appmenu-plugin \
        docker-ce docker-ce-cli containerd.io rofi spotify-client vlc stacer lightdm slick-greeter -yqq

    mkdir -p /usr/share/backgrounds
    wget -q https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg && mv LEps6S.jpg /usr/share/backgrounds/linux-wallpaper-01.jpg

    LIGHTDM_SLICK_GREETER_CONFIG_FILE="/etc/lightdm/slick-greeter.conf"
    echo "[Greeter]" >$LIGHTDM_SLICK_GREETER_CONFIG_FILE
    echo "background=/usr/share/backgrounds/linux-wallpaper-01.jpg" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
    echo "draw-user-backgrounds=false" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
    echo "theme-name=Mint-Y-Dark" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
    echo "icon-theme-name=Mint-Y-Dark" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
    echo "activate-numlock=true" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
    echo "draw-grid=false" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE

    LIGHTDM_MAIN_CONFIG_FILE="/etc/lightdm/lightdm.conf"
    echo " " >>$LIGHTDM_MAIN_CONFIG_FILE
    echo "[SeatDefaults]" >>$LIGHTDM_MAIN_CONFIG_FILE
    echo "greeter-show-manual-login = false" >>$LIGHTDM_MAIN_CONFIG_FILE
    echo "greeter-hide-users = false" >>$LIGHTDM_MAIN_CONFIG_FILE
    echo "allow-guest = false" >>$LIGHTDM_MAIN_CONFIG_FILE

    usermod -aG docker $USER

    echo " "
    echo "DONE"
}

############
case "$1" in

install)
    install_all
    get_i3_config
    get_zsh_config
    get_php_composer
    get_docker_compose
    ;;

i3-config)
    get_i3_config
    ;;

zsh-config)
    get_zsh_config
    ;;

php-composer)
    get_php_composer
    ;;

docker-compose)
    get_docker_compose
    ;;

*)
    echo " "
    echo "Usage: install | i3-config | zsh-config | php-composer | docker-compose"
    echo "./debian-xfce-i3_x64.sh install | Install everything and get the latest configurations"
    echo "./debian-xfce-i3_x64.sh i3-config | Download the latest i3-configuration from GitHub"
    echo "./debian-xfce-i3_x64.sh zsh-config | Download the latest zsh-configuration from GitHub"
    echo "./debian-xfce-i3_x64.sh php-composer | Download and install the latest php-composer script"
    echo "./debian-xfce-i3_x64.sh docker-compose | Download and install the latest docker-compose script"
    echo " "
    ;;

esac
exit
