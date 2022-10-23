#!/usr/bin/env bash

vhost_file="/etc/apache2/sites-enabled/wwwsrv_vhost.conf"
hosts_file="/etc/hosts"
# browser="google-chrome"

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

echo "WARNING! THIS SCRIPT WILL RESTART YOUR WEB-SERVER (APACHE) PRESS ENTER TO CONTINUE OR CTRL+C TO EXIT"
read -r

mkdir -p logs

www_path=$(pwd)
www_name="$(basename "$PWD").local"

old_host=$(cat /etc/hosts | grep -A1 'wwwsrv' | grep 127.0.0.1)

sudo sed -i "/$old_host/d" "$hosts_file" 2>/dev/null
sudo sed -i "/wwwsrv/d" "$hosts_file" 2>/dev/null

echo "<VirtualHost *:80>" | sudo tee $vhost_file >/dev/null
echo "  DocumentRoot $www_path" | sudo tee -a $vhost_file >/dev/null
echo "  ServerName $www_name" | sudo tee -a $vhost_file >/dev/null
echo "  ServerAdmin webmaster@localhost" | sudo tee -a $vhost_file >/dev/null
echo "  ErrorLog $www_path/logs/apache_error.log" | sudo tee -a $vhost_file >/dev/null
echo "  CustomLog $www_path/logs/apache_access.log combined" | sudo tee -a $vhost_file >/dev/null
echo "  <Directory $www_path/>" | sudo tee -a $vhost_file >/dev/null
echo "    AllowOverride All" | sudo tee -a $vhost_file >/dev/null
echo "    Options +Indexes" | sudo tee -a $vhost_file >/dev/null
echo "    Require all granted" | sudo tee -a $vhost_file >/dev/null
echo " </Directory>" | sudo tee -a $vhost_file >/dev/null
echo "</VirtualHost>" | sudo tee -a $vhost_file >/dev/null

echo "wwwsrv" | sudo tee -a $hosts_file >/dev/null
echo "127.0.0.1 $www_name" | sudo tee -a $hosts_file >/dev/null

sudo systemctl restart apache2.service

echo "CONTENTS OF HOST-FILE"
echo "---------------------"
cat "$hosts_file"

echo " "
echo "CONTENTS OF APACHE VHOST-FILE"
echo "-----------------------------"
cat "$vhost_file"

echo " "
echo "YOUR WEB-SERVER (APACHE) IS NOW RUNING AND YOU SHALL BE ABLE TO ACCESS IT ON: http://$www_name"
echo " "

# $browser http://"$www_name" 2>/dev/null
