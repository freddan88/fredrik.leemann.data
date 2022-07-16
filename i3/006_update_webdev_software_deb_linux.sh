#!/usr/bin/env bash

url_composer_installer="https://getcomposer.org/installer"
url_docker_compose_github_latest="https://github.com/docker/compose/releases/latest"

# Link to file on GitHub
# https://github.com/freddan88/fredrik.linux.files/blob/main/i3/005_software_webdev_deb_linux.sh

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

if [ ! "$SUDO_USER" ] || [ "$SUDO_USER" = "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

apt update -qq
apt install curl wget git gzip bzip2 unzip zip tar lsb-release -y

echo " "
echo "UPDATING PHP COMPOSER" && sleep 2
echo " "

cd /tmp && rm -f /usr/local/bin/composer
cd /tmp && wget $url_composer_installer && php ./installer
cd /tmp && mv -f composer.phar /usr/local/bin/composer && chmod -f 755 /usr/local/bin/composer
cd /tmp && rm -f installer

echo " "
echo "INSTALLED THE COMMAND 'COMPOSER' GLOBALLY IN: /usr/local/bin/composer"
echo " "
echo "UPDATING DOCKER COMPOSE" && sleep 2
echo " "

latest_docker_compose=$(curl -s $url_docker_compose_github_latest | cut -d'"' -f2)
latest_docker_compose_version=$(echo $latest_docker_compose | cut -d'/' -f8)

cd /tmp && rm -f /usr/local/bin/docker-compose
cd /tmp && wget -q https://github.com/docker/compose/releases/download/$latest_docker_compose_version/docker-compose-Linux-x86_64
cd /tmp && mv -f docker-compose-Linux-x86_64 /usr/local/bin/docker-compose && chmod -f 755 /usr/local/bin/docker-compose

echo " "
echo "INSTALLED THE COMMAND 'DOCKER-COMPOSE' GLOBALLY IN: /usr/local/bin/docker-compose"
echo " "
echo "DONE!"
echo " "
