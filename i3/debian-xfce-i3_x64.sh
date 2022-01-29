#!/bin/bash

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
  echo "UPDATING i3 CONFIG" && sleep 2
  I3_CONFIG=$(curl -s https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/config-i3-xfce.txt)
  mkdir -p $SUDO_USER_HOME/.config/i3 && echo $I3_CONFIG >$SUDO_USER_HOME/.config/i3/config
  chmod -R 775 $SUDO_USER_HOME/.config/i3 && chmod 664 $SUDO_USER_HOME/.config/i3/config && chown -R $SUDO_USER:$SUDO_USER $SUDO_USER_HOME/.config/i3
  echo "Wrote new i3-configuration to: $SUDO_USER_HOME/.config/i3/config"
}

get_zsh_config() {
  echo " "
  echo "UPDATING ZSH CONFIG" && sleep 2
  ZSH_CONFIG=$(curl -s https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/shell/zshrc.txt)
  echo $ZSH_CONFIG >$SUDO_USER_HOME/.zshrc
  chmod 644 $SUDO_USER_HOME/.zshrc && chown $SUDO_USER:$SUDO_USER $SUDO_USER_HOME/.zshrc
  echo "Wrote new zsh-configuration to: $SUDO_USER_HOME/.zshrc"
}

get_php_composer() {
  echo " "
  echo "UPDATING PHP COMPOSER" && sleep 2
  rm -f /usr/local/bin/composer
  wget -q https://getcomposer.org/installer && php ./installer >/dev/null
  mv composer.phar /usr/local/bin/composer && chmod 755 /usr/local/bin/composer
  echo "Installed the command: composer globally in: /usr/local/bin/composer"
}

get_docker_compose() {
  echo " "
  echo "UPDATING DOCKER COMPOSE" && sleep 2
  rm -f /usr/local/bin/docker-compose
  LATEST_DOCKER_COMPOSE=$(curl -s https://github.com/docker/compose/releases/latest | cut -d'"' -f2)
  LATEST_DOCKER_COMPOSE_VERSION=$(echo $LATEST_DOCKER_COMPOSE | cut -d'/' -f8)
  wget -q https://github.com/docker/compose/releases/download/$LATEST_DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64
  mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose && chmod 755 /usr/local/bin/docker-compose
  echo "Installed the command: docker-compose globally in: /usr/local/bin/docker-compose"
}

run_config_lightdm_slick_greeter() {
  echo " "
  echo "CONFIGURING LIGHTDM SLICK GREETER" && sleep 2
  LIGHTDM_SLICK_GREETER_CONFIG_FILE="/etc/lightdm/slick-greeter.conf"
  echo "[Greeter]" >$LIGHTDM_SLICK_GREETER_CONFIG_FILE
  echo "background=/usr/share/backgrounds/linux-wallpaper-01.jpg" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
  echo "draw-user-backgrounds=false" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
  echo "theme-name=Arc-Dark" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
  echo "icon-theme-name=elementary-xfce-dark" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
  echo "activate-numlock=true" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
  echo "draw-grid=false" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
  echo "clock-format=%R | %F v%V" >>$LIGHTDM_SLICK_GREETER_CONFIG_FILE
  echo "Wrote new config in: $LIGHTDM_SLICK_GREETER_CONFIG_FILE"
}

install_all() {
  echo " "
  echo "INITIALIZE" && sleep 2
  apt update -qq && apt install ca-certificates git unzip zip curl net-tools nano pwgen gnupg lsb-release gparted synaptic neofetch -yqq

  echo " "
  echo "ADDING KEYS AND REPOSITORIES" && sleep 2
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --batch --yes --output /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null

  wget -q -O- https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --dearmor --batch --yes | tee /usr/share/keyrings/spotify-archive-keyring.gpg >/dev/null

  # curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | apt-key add - >/dev/null
  echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list >/dev/null

  echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | tee -a /etc/apt/sources.list.d/insomnia.list >/dev/null

  echo " "
  echo "ADDING PACKAGES AND STUFF" && sleep 2
  cd /tmp
  wget -q $URL_MONGODB_COMPASS && apt install ./mongodb-compass_*_amd64.deb -yqq
  wget -q $URL_JETBRAINS_MONOFONT && unzip -qqo JetBrainsMono*.zip && cp fonts/ttf/JetBrainsMono*.ttf /usr/share/fonts/
  wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt install ./google-chrome-stable_current_amd64.deb -yqq

  # LATEST_MYSQL=$(curl -s https://dev.mysql.com/downloads/repo/apt/ | grep mysql-apt-config | cut -d'(' -f2 | cut -d')' -f1)
  # wget -q https://dev.mysql.com/get/$LATEST_MYSQL && apt install ./mysql-apt-config_*_all.deb -yqq

  URL_LATEST_VSCODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  wget -q -O vscode_amd64.deb $URL_LATEST_VSCODE
  apt install ./vscode_amd64.deb -yqq

  wget -q https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
  apt install ./dbeaver-ce_*_amd64.deb -yqq

  apt update -qq
  apt install ufw gufw fail2ban gimp arc-theme elementary-xfce-icon-theme thunderbird nitrogen libreoffice compton sqlite3 libpcre3 libsodium23 insomnia spotify-client -yqq
  apt install apache2 php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} libapache2-mod-php -yqq
  apt install imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 -yqq
  apt install openssl libapache2-mpm-itk libmagickcore-6.q16hdri-3-extra libmagickcore-6.q16-6-extra ffmpeg ghostscript xfce4-screenshooter xfce4-appmenu-plugin i3 -yqq
  apt install docker-ce docker-ce-cli containerd.io rofi imagemagick stacer lightdm slick-greeter libappindicator3-0.1-cil libappindicator3-0.1-cil-dev ssh zsh vlc -yqq

  mkdir -p /usr/share/backgrounds
  wget -q https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg && mv LEps6S.jpg /usr/share/backgrounds/linux-wallpaper-01.jpg

  LIGHTDM_MAIN_CONFIG_FILE="/etc/lightdm/lightdm.conf"
  echo " " >>$LIGHTDM_MAIN_CONFIG_FILE
  echo "[SeatDefaults]" >>$LIGHTDM_MAIN_CONFIG_FILE
  echo "greeter-show-manual-login = false" >>$LIGHTDM_MAIN_CONFIG_FILE
  echo "greeter-hide-users = false" >>$LIGHTDM_MAIN_CONFIG_FILE
  echo "allow-guest = false" >>$LIGHTDM_MAIN_CONFIG_FILE

  usermod -aG docker $SUDO_USER

  get_i3_config
  get_zsh_config
  get_php_composer
  get_docker_compose
  run_config_lightdm_slick_greeter

  echo " "
}

############
case "$1" in

install)
  install_all
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

config-lightdm-slick-greeter)
  run_config_lightdm_slick_greeter
  ;;

*)
  echo " "
  echo "Usage: install | i3-config | zsh-config | php-composer | docker-compose | config-lightdm-slick-greeter"
  echo "./debian-xfce-i3_x64.sh install | Install everything and get the latest configurations"
  echo "./debian-xfce-i3_x64.sh i3-config | Download the latest i3-configuration from GitHub"
  echo "./debian-xfce-i3_x64.sh zsh-config | Download the latest zsh-configuration from GitHub"
  echo "./debian-xfce-i3_x64.sh php-composer | Download and install the latest php-composer script"
  echo "./debian-xfce-i3_x64.sh docker-compose | Download and install the latest docker-compose script"
  echo "./debian-xfce-i3_x64.sh config-lightdm-slick-greeter | Write a new configuration-file for the login-screen"
  echo " "
  ;;

esac
exit
