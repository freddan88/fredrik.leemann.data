#!/bin/sh
#
# Author: Fredrik Leemann
# Website: www.leemann.se/fredrik
# Updated: 2022-03-06

web_browser=$(xdg-settings get default-web-browser)
if [ -n "${web_browser}" ]; then
    web_browser=$(echo $web_browser | cut -f1 -d.)
else
    web_browser="firefox"
fi

network_port=$PHPSRV_NETWORK_PORT
if [ -z "${network_port}" ]; then
    network_port="8080"
fi

network_ip=$PHPSRV_NETWORK_IP
if [ -z "${network_ip}" ]; then
    network_ip=0.0.0.0
fi

########
echo " "
echo "PHP-server will listen for request on: $network_ip:$network_port"
echo "PHP-server will serve files from: ${PWD}"
echo " "

sleep 2

$web_browser http://localhost:$network_port &

php -S $network_ip:$network_port
