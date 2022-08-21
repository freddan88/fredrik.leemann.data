#!/usr/bin/env bash

lan_port=8000
lan_interface=enp0s3
browser=google-chrome
# browser=firefox

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

echo " "
echo "PHP Server version 2.2.5 Linux"
echo " "
echo "Server listening on:"
echo "--------------------"
# soc1="$(ip addr | grep $lan_interface | sed -En -e 's/.*inet ([0-9.]+).*/\1/p'):$lan_port"
soc1="$(ip addr | grep $lan_interface | grep inet | xargs | cut -d"/" -f1 | cut -d" " -f2):$lan_port"
soc2=127.0.0.1:"$lan_port"
soc3=localhost:"$lan_port"

echo " "
echo "$soc1"
echo "$soc2"
echo "$soc3"
echo " "

php -S 0.0.0.0:$lan_port >/dev/null &
php_server_pid=$!

$browser http://"$soc1" 2>/dev/null
kill -9 $php_server_pid
