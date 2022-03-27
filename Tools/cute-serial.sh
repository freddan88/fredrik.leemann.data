#!/bin/bash
if [ "$(id -u)" != "0" ]; then 
echo "This script needs to be executed as sudo" 
echo " " && exit; fi

if ! [ -f /usr/bin/cutecom ]; then
	echo "We will need to install cutecom"
	apt-get update && apt-get install cutecom -y
fi

mkdir -p $HOME/.config/CuteCom
echo [cutecom] > $HOME/.config/CuteCom/CuteCom.conf
echo AllDevices=$(ls -f /dev/ttyU* /dev/ttyS* 2>/dev/null | tr "\n" ",") >> $HOME/.config/CuteCom/CuteCom.conf

if [ -c /dev/ttyUSB0 ]; then
	echo CurrentDevice=/dev/ttyUSB0 >> $HOME/.config/CuteCom/CuteCom.conf
else
	echo CurrentDevice=/dev/ttyS0 >> $HOME/.config/CuteCom/CuteCom.conf
fi

echo Baud=13 >> $HOME/.config/CuteCom/CuteCom.conf
##################################################
echo " "
sleep 1 && cutecom