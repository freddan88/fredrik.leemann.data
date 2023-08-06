#!/usr/bin/env bash

if [ ! "$SUDO_USER" ] || [ "$SUDO_USER" = "root" ]; then
  echo " "
  echo "PLEASE RUN THIS SCRIPT AS A SUDO-USER"
  echo " "
  exit
fi

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

hosts_file="/etc/hosts"
vhost_file="/etc/apache2/sites-enabled/wwwsrv_vhost.conf"

if [ -f "$hosts_file" ] && [ -f "$vhost_file" ]; then
  echo "THIS SCRIPT WILL RESTART YOUR WEB-SERVER (APACHE2) PRESS ENTER TO CONTINUE OR CTRL+C TO EXIT"

  read -r
  mkdir -p logs

  www_path=$(pwd)
  www_alias=$(basename "$PWD" | tr '[:upper:]' '[:lower:]')

  echo "<VirtualHost *:80>" | tee $vhost_file >/dev/null
  echo "  DocumentRoot $www_path" | tee -a $vhost_file >/dev/null
  echo "  ServerName $www_alias" | tee -a $vhost_file >/dev/null
  echo "  ServerAdmin webmaster@localhost" | tee -a $vhost_file >/dev/null
  echo "  ErrorLog $www_path/logs/apache_error.log" | tee -a $vhost_file >/dev/null
  echo "  CustomLog $www_path/logs/apache_access.log combined" | tee -a $vhost_file >/dev/null
  echo "  <Directory $www_path/>" | tee -a $vhost_file >/dev/null
  echo "    AllowOverride All" | tee -a $vhost_file >/dev/null
  echo "    Options +Indexes" | tee -a $vhost_file >/dev/null
  echo "    Require all granted" | tee -a $vhost_file >/dev/null
  echo " </Directory>" | tee -a $vhost_file >/dev/null
  echo "</VirtualHost>" | tee -a $vhost_file >/dev/null

  current_host=$(cat $hosts_file | grep 127.0.0.1 | grep localhost)

  sed -i "s/$current_host/127.0.0.1 localhost $www_alias/g" $hosts_file

  echo "127.0.0.1 $www_alias" | tee -a $hosts_file >/dev/null

  echo " "
  echo "RESTARTING APACHE2 (WEB-SERVER)"
  echo "-------------------------------"

  sleep 2 && systemctl restart apache2.service

  echo " "
  echo "LOGGFILES CAN BE FOUND HERE"
  echo "---------------------------"
  cat "$www_path/logs"

  echo " "
  echo "CONTENTS OF YOUR HOST-FILE"
  echo "--------------------------"
  cat "$hosts_file"

  echo " "
  echo "CONTENTS OF APACHE VHOST-FILE"
  echo "-----------------------------"
  cat "$vhost_file"

  echo " "
  echo "YOUR WEB-SITE IS NOW RUNING AND YOU SHALL BE ABLE TO ACCESS IT ON: http://$www_name"
  echo " "
fi
