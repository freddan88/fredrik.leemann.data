#!/usr/bin/env bash

echo " "
echo "This script lets you configure your keyboard-layout using dpkg-reconfigure"

echo " "
echo "You need to restart the proccess to apply the new configuration"
echo "You can also restart your computer to apply it"
echo " "
echo "Command: sudo service keyboard-setup restart"
echo "--------------------------------------------"
echo " "

sudo dpkg-reconfigure keyboard-configuration
