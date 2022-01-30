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

echo " "
echo "Sudo-user username: $SUDO_USER"
echo "Sudo-user home-directory: $SUDO_USER_HOME"

get_i3_config() {
  echo " "
  echo "UPDATING i3 CONFIG" && sleep 2
  mkdir -p $SUDO_USER_HOME/.config/i3
  cd $SUDO_USER_HOME/.config/i3
  rm -f $SUDO_USER_HOME/.config/i3/config
  wget -q -O config https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/i3/config-i3-xfce.txt
  chmod -R 775 $SUDO_USER_HOME/.config/i3 && chmod 664 config && chown -R $SUDO_USER:$SUDO_USER $SUDO_USER_HOME/.config/i3
  echo "Wrote new i3-configuration to: $SUDO_USER_HOME/.config/i3/config"
}

get_zsh_config() {
  echo " "
  echo "UPDATING ZSH CONFIG" && sleep 2
  cd $SUDO_USER_HOME
  rm -f $SUDO_USER_HOME/.zshrc
  wget -q -O .zshrc https://raw.githubusercontent.com/freddan88/fredrik.linux.files/main/shell/zshrc.txt
  chmod 644 .zshrc && chown $SUDO_USER:$SUDO_USER .zshrc
  echo "Wrote new zsh-configuration to: $SUDO_USER_HOME/.zshrc"
}

get_php_composer() {
  echo " "
  echo "UPDATING PHP COMPOSER" && sleep 2
  cd /tmp
  rm -f installer && rm -f /usr/local/bin/composer
  wget -q https://getcomposer.org/installer && php ./installer >/dev/null
  mv composer.phar /usr/local/bin/composer && chmod 755 /usr/local/bin/composer
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
  mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose && chmod 755 /usr/local/bin/docker-compose
  echo "Installed the command: docker-compose globally in: /usr/local/bin/docker-compose"
}

get_latest_postman() {
  echo " "
  echo "UPDATING POSTMAN APP" && sleep 2
  cd /tmp
  rm -f postman-x64.tar.gz && rm -f /opt/Postman/app/postman
  wget -q -O postman-x64.tar.gz https://dl.pstmn.io/download/latest/linux64 && tar -xf postman-x64.tar.gz
  mv Postman /opt && ln -s /opt/Postman/app/postman /usr/local/bin/postman
  chmod 775 /opt/Postman/app/postman
  echo "Installed the latest api-testing app globally in: /usr/local/bin/postman and /opt/Postman"
}

install_all() {
  echo " "
  echo "INITIALIZE" && sleep 2
  cd /tmp
  apt update -qq && apt install ca-certificates curl wget gzip tar nano ssh git gnupg lsb-release gparted pwgen -y

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

  apt update -qq
  apt install ufw gufw fail2ban gimp vlc arc-theme elementary-xfce-icon-theme thunderbird nitrogen libreoffice compton sqlite3 libpcre3 libsodium23 sqlitebrowser -y
  apt install apache2 php php-{bcmath,cli,common,xdebug,curl,soap,gd,mbstring,mysql,opcache,readline,sqlite3,xml,zip,imagick,pear,cgi,phpseclib} libapache2-mod-php -y
  apt install imagemagick-common imagemagick-6-common imagemagick-6.q16 imagemagick-6.q16hdri libmagickcore-6.q16-6 libmagickwand-6.q16-6 libmagickwand-6.q16hdri-6 -y
  apt install openssl libapache2-mpm-itk libmagickcore-6.q16hdri-3-extra libmagickcore-6.q16-6-extra ffmpeg ghostscript xfce4-screenshooter xfce4-appmenu-plugin i3 -y
  apt install docker-ce docker-ce-cli containerd.io rofi imagemagick stacer lightdm slick-greeter zsh numlockx catfish unzip zip net-tools synaptic neofetch -y

  mkdir -p /usr/share/backgrounds
  wget -q https://img.wallpapersafari.com/desktop/1920/1080/95/51/LEps6S.jpg && mv LEps6S.jpg /usr/share/backgrounds/linux-wallpaper-01.jpg

  usermod -aG docker $SUDO_USER

  get_i3_config
  get_php_composer
  get_docker_compose
  get_latest_postman

  echo " "
  echo "DISABLING APACHE2 HTTP SERVER FROM AUTO STARTING AT BOOT AND STOPPING THE RUNNING PROCESS"
  systemctl disable apache2.service
  systemctl stop apache2.service

  touch $SUDO_USER_HOME/.debian-xfce-i3_x64.lock

  echo " "
}

print_usage() {
  echo " "
  echo "Usage: install | i3-config | zsh-config | php-composer | docker-compose | config-lightdm-slick-greeter"
  echo "./debian-xfce-i3_x64.sh install | Install everything and get the latest configurations"
  echo "./debian-xfce-i3_x64.sh i3-config | Download the latest i3-configuration from GitHub"
  echo "./debian-xfce-i3_x64.sh zsh-config | Download the latest zsh-configuration from GitHub"
  echo "./debian-xfce-i3_x64.sh php-composer | Download and install the latest php-composer script"
  echo "./debian-xfce-i3_x64.sh docker-compose | Download and install the latest docker-compose script"
  echo "./debian-xfce-i3_x64.sh postman-app | Download and install the latest postman api-testing app"
  echo " "
}

############
case "$1" in

install)
  if [ -d "$SUDO_USER_HOME/.debian-xfce-i3_x64.lock" ]; then
    echo "Script already run!"
    print_usage
    exit
  fi
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

postman-app)
  get_latest_postman
  ;;

*)
  print_usage
  ;;

esac
exit
