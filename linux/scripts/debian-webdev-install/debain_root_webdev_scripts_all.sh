#!/usr/bin/env bash

url_composer_installer="https://getcomposer.org/installer"
url_docker_compose="https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64"

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
echo "UPDATING WEBDEV SOFTWARE" && sleep 2
echo " "

cd /tmp && rm -f /usr/local/bin/composer
cd /tmp && wget $url_composer_installer && php ./installer
cd /tmp && mv -f composer.phar /usr/local/bin/composer && chmod -f 755 /usr/local/bin/composer
cd /tmp && rm -f installer

echo " "
echo "INSTALLED THE COMMAND 'COMPOSER' GLOBALLY IN: /usr/local/bin/composer"
echo " "

cd /tmp && rm -f /usr/local/bin/docker-compose
cd /tmp && wget $url_docker_compose
cd /tmp && mv -f docker-compose-linux-x86_64 /usr/local/bin/docker-compose && chmod -f 755 /usr/local/bin/docker-compose

echo " "
echo "INSTALLED THE COMMAND 'DOCKER-COMPOSE' GLOBALLY IN: /usr/local/bin/docker-compose"

echo " "
echo "DONE!"
echo " "
