#!/bin/bash
if [ "$(id -u)" != "0" ]; then 
	echo "This script needs to be executed as sudo" 
	echo " "
	exit 
fi

if ! [ -f /usr/bin/minicom ]; then
	echo "We will need to install minicom"
	apt-get update && apt-get install minicom -y
fi

function new_conf {
	rm -f /tmp/recent_dev.txt
	ls /dev/ttyS* 2>/dev/null > /tmp/tty-devices.temp
	ls /dev/ttyU* 2>/dev/null >> /tmp/tty-devices.temp
	echo " "
	echo "Listing devices:"
	echo " "
	cat /tmp/tty-devices.temp
	rm -f /tmp/tty-devices.temp
	echo " "
	echo "Minicom will always start with 9600 Baud"
	echo "Copy and paste the device name and path above"
	echo "This script will exit if you dont give a device"
	echo "Example: Device to use?: /dev/ttyS0"
	echo " "
	echo -n "Device to use?: "
	read dev
	echo " "
	if [[ $dev == "/dev/tty"* ]]; then
		echo $dev > /tmp/recent_dev.txt
		minicom -b 9600 -D $dev 2>/dev/null
	fi
}

if [ -f /tmp/recent_dev.txt ]; then
	dev=$(cat /tmp/recent_dev.txt)

	if ! [ -c $dev ]; then
		echo " "
		echo "Recent device not present on this computer anymore"
		new_conf && exit
	else
		echo " "
		echo "Minicom will always start with 9600 Baud"	
		echo "Recent device: $(cat /tmp/recent_dev.txt)"
		echo "Press y to use or any other key for new configuration"
		echo " "	
		echo -n "Use this device $(cat /tmp/recent_dev.txt)?"
		read conf
	fi

	if [ "$conf" == "y" ]; then
		echo " "
		minicom -b 9600 -D $dev 2>/dev/null
	else
		new_conf && exit
	fi	
else
	new_conf && exit
fi