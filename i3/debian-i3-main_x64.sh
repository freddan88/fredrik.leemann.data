#!/bin/bash

URL_MONGODB_COMPASS="https://github.com/mongodb-js/compass/releases/download/v1.30.1/mongodb-compass_1.30.1_amd64.deb"
URL_JETBRAINS_MONOFONT="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip"
URL_ZSH_CONFIG="https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/shell/zshrc.txt"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

if [ -f "debian-i3.conf" ]; then
  source debian-i3.conf
fi

SUDO_USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

get_i3_config() {
  echo " "
  if [ -z "$URL_I3_CONFIG" ]; then
    echo "ERROR: URL TO DOWNLOAD I3-CONFIG IS NOT SET"
    exit
  fi
  echo "UPDATING i3 CONFIG" && sleep 2
  mkdir -p $SUDO_USER_HOME/.config/i3
  cd $SUDO_USER_HOME/.config/i3
  rm -f $SUDO_USER_HOME/.config/i3/config
  wget -q -O config $URL_I3_CONFIG
  chmod -Rf 775 $SUDO_USER_HOME/.config/i3 && chmod -f 644 config && chown -Rf $SUDO_USER:$SUDO_USER $SUDO_USER_HOME/.config/i3
  echo "Wrote new i3-configuration to: $SUDO_USER_HOME/.config/i3/config"
}

get_zsh_config() {
  echo " "
  echo "UPDATING ZSH CONFIG" && sleep 2
  cd $SUDO_USER_HOME
  rm -f $SUDO_USER_HOME/.zshrc
  wget -q -O .zshrc $URL_ZSH_CONFIG
  chmod -f 644 .zshrc && chown -f $SUDO_USER:$SUDO_USER .zshrc
  echo "Wrote new zsh-configuration to: $SUDO_USER_HOME/.zshrc"
}

get_php_composer() {
  echo " "
  echo "UPDATING PHP COMPOSER" && sleep 2
  cd /tmp
  rm -f installer && rm -f /usr/local/bin/composer
  wget -q https://getcomposer.org/installer && php ./installer >/dev/null
  mv -f composer.phar /usr/local/bin/composer && chmod -f 755 /usr/local/bin/composer
  echo "Installed the command: composer globally in: /usr/local/bin/composer"
}

get_docker_compose() {
  echo " "
  echo "UPDATING DOCKER COMPOSE" && sleep 2
  cd /tmp
  rm -f /usr/local/bin/docker-compose
  LATEST_DOCKER_COMPOSE=$(curl -s https://github.com/docker/compose/releases/latest | cut -d'"' -f2)
  LATEST_DOCKER_COMPOSE_VERSION=$(echo $LATEST_DOCKER_COMPOSE | cut -d'/' -f8)
  wget -q https://github.com/docker/compose/releases/download/$LATEST_DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64
  mv -f docker-compose-Linux-x86_64 /usr/local/bin/docker-compose && chmod -f 755 /usr/local/bin/docker-compose
  echo "Installed the command: docker-compose globally in: /usr/local/bin/docker-compose"
}

get_latest_postman() {
  echo " "
  echo "UPDATING POSTMAN APP" && sleep 2
  cd /tmp
  rm -f postman-x64.tar.gz && rm -R -f /opt/Postman && rm -f /usr/local/bin/postman
  wget -q -O postman-x64.tar.gz https://dl.pstmn.io/download/latest/linux64 && tar -xf postman-x64.tar.gz
  mv -f Postman /opt && ln -s /opt/Postman/app/postman /usr/local/bin/postman
  chmod -f 775 /opt/Postman/app/postman
  echo "Installed the latest api-testing app globally in: /usr/local/bin/postman and /opt/Postman"
}

install_all() {
  echo " "
  echo "INITIALIZE" && sleep 2
  cd /tmp
  apt update -qq && apt install ca-certificates curl wget gzip tar nano ssh git gnupg lsb-release gparted pwgen unzip zip net-tools unclutter -y

  echo " "
  echo "ADDING KEYS AND REPOSITORIES" && sleep 2
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --batch --yes --output /usr/share/keyrings/docker-archive-keyring.gpg >/dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null

  echo " "
  echo "ADDING PACKAGES AND STUFF" && sleep 2
  cd /tmp
  wget -q $URL_MONGODB_COMPASS && apt install ./mongodb-compass_*_amd64.deb -y
  wget -q $URL_JETBRAINS_MONOFONT && unzip -qqo JetBrainsMono*.zip && cp fonts/ttf/JetBrainsMono*.ttf /usr/share/fonts/
  wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt install ./google-chrome-stable_current_amd64.deb -y

  URL_LATEST_VSCODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  wget -q -O vscode_amd64.deb $URL_LATEST_VSCODE
  apt install ./vscode_amd64.deb -y

  wget -q https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
  apt install ./dbeaver-ce_*_amd64.deb -y

  apt install i3 i3status suckless-tools rofi playerctl xbacklight numlockx unclutter neofetch nitrogen git zsh curl tar bzip2 zip unzip nano ffmpeg lshw htop ssh vlc -y
  apt install ufw gufw openssl sqlite3 fail2ban ffmpeg gimp mirage stacer synaptic thunderbird libreoffice ghostscript debian-edu-artwork gnome-icon-theme libpcre3 -y
  apt install apache2 php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} libapache2-mod-php -y
  apt install libapache2-mpm-itk libsodium23 sqlitebrowser docker-ce docker-ce-cli containerd.io imagemagick imagemagick-common imagemagick-6-common imagemagick-6.q16 -y
  apt install imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 libmagickcore-6.q16-6-extra libmagickcore-6.q16hdri-3-extra -y

  mkdir -p /usr/share/backgrounds
  wget -q https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg && mv -f LEps6S.jpg /usr/share/backgrounds/linux-wallpaper-01.jpg

  cd $SUDO_USER_HOME/.config/i3
  wget -q https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/configs/i3status.conf

  usermod -aG docker $SUDO_USER
  ln -s /sbin/ifconfig /usr/bin/ifconfig

  echo " "
  echo "DISABLING APACHE2 HTTP SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
  systemctl disable apache2.service
  systemctl stop apache2.service

  echo " "
  echo "CREATED LOCKFILE IN: /var/lock/debian-i3.lock"
  touch /var/lock/debian-i3.lock

  get_i3_config
  get_zsh_config
  get_php_composer
  get_latest_postman
  get_docker_compose
  print_usage
}

print_usage() {
  echo " "
  echo "USAGE: install | i3-config | zsh-config | php-composer | docker-compose | postman-app"
  echo "$0 install | Install everything and get the latest configurations"
  echo "$0 i3-config | Download the latest i3-configuration from GitHub - Requires variable for download_url"
  echo "$0 zsh-config | Download the latest zsh-configuration from GitHub"
  echo "$0 php-composer | Download and install the latest php-composer script"
  echo "$0 docker-compose | Download and install the latest docker-compose script"
  echo "$0 postman-app | Download and install the latest postman api-testing app"
  echo " "
}

############
case "$1" in

install)
  if [ -f "/var/lock/debian-i3.lock" ]; then
    echo " "
    echo "THE SCRIPT HAS ALREADY RUN WITH ARGUMENT: INSTALL"
    print_usage
    exit
  fi
  install_all
  print_usage
  ;;

i3-config)
  get_i3_config
  print_usage
  ;;

zsh-config)
  get_zsh_config
  print_usage
  ;;

php-composer)
  get_php_composer
  print_usage
  ;;

docker-compose)
  get_docker_compose
  print_usage
  ;;

postman-app)
  get_latest_postman
  print_usage
  ;;

*)
  print_usage
  ;;

esac
exit
