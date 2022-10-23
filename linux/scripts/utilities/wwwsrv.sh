#!/usr/bin/env bash

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

mkdir -p logs

www_path=$(pwd)
www_name="$(basename "$PWD")"

vhost_file="/etc/apache2/sites-enabled/wwwsrv_vhost.conf"
hosts_file="/etc/hosts"

echo "<VirtualHost *:80>" | sudo tee $vhost_file >/dev/null
echo "  ServerName $www_name" | sudo tee -a $vhost_file >/dev/null
echo "  ServerAdmin webmaster@localhost" | sudo tee -a $vhost_file >/dev/null
echo "  DocumentRoot $www_path" | sudo tee -a $vhost_file >/dev/null
echo "  ErrorLog $www_path/logs/apache_error.log" | sudo tee -a $vhost_file >/dev/null
echo "  CustomLog $www_path/logs/apache_access.log combined" | sudo tee -a $vhost_file >/dev/null
echo "</VirtualHost>" | sudo tee -a $vhost_file >/dev/null

echo " " | sudo tee -a $hosts_file >/dev/null
echo "wwwsrv" | sudo tee -a $hosts_file >/dev/null
echo "127.0.0.1 $www_name" | sudo tee -a $hosts_file >/dev/null

sudo systemctl restart apache2.service
