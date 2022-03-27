#!/bin/sh
# This scrip launches MiniCom Serial Terminal
# You need to install minicom, sudo apt-get install minicom on ubuntu
# Tip to find Serial Device: tail /var/log/syslog
echo "Serial Divices:"
dmesg | grep -e tty
echo ""
echo "Use 'man minicom' for help or 'sudo minicom -s' to setup a new profile"
echo ""
echo "Options:"
echo "1 = Serial Terminal to: Cisco, HP ProCurve, Alcatel, SUN, Nortel/Avaya" 
echo "2 = Serial Terminal to: Manual Configuration (Option 3)"
echo "3 = Manual Configuration"
echo "4 = Manual MiniCom Setup"
echo "5 = Exit Script"
read -p "Number:" OPT
if [ "$OPT" = "1" ]; then sudo minicom /home/anv1/Tools/script/minicom/conf/minirc.base.conf ; fi
if [ "$OPT" = "2" ]; then sudo minicom /home/anv1/Tools/script/minicom/conf/minirc.manual.conf ; fi
if [ "$OPT" = "4" ]; then sudo minicom -s ; fi
if [ "$OPT" = "5" ]; then exit ; fi
if [ "$OPT" = "3" ]; then echo "Manual:" 
read -p "Baud rate:(9600/38400/115200)" BAUD
read -p "Data bits:(8/7)" DATA
read -p "Parity:(N/E)" PARITY
read -p "Stop bits:(1/2)" STOP
read -p "Hardware flow control:(Yes/No)" RTSCTS
read -p "Software flow control:(Yes/No)" XONXOFF

echo "pu port /dev/ttyS0" > /home/anv1/Tools/script/minicom/conf/minirc.manual.conf
echo "pu baudrate $BAUD" >> /home/anv1/Tools/script/minicom/conf/minirc.manual.conf
echo "pu bits $DATA" >> /home/anv1/Tools/script/minicom/conf/minirc.manual.conf
echo "pu parity $PARITY" >> /home/anv1/Tools/script/minicom/conf/minirc.manual.conf
echo "pu stopbits $STOP" >> /home/anv1/Tools/script/minicom/conf/minirc.manual.conf
echo "pu updir /home/anv1/Tools/firmware" >> /home/anv1/Tools/script/minicom/conf/minirc.manual.conf
echo "pu downdir /home/anv1/Tools/firmware" >> /home/anv1/Tools/script/minicom/conf/minirc.manual.conf
echo "pu rtscts $RTSCTS" >> /home/anv1/Tools/script/minicom/conf/minirc.manual.conf
echo "pu xonxoff $XONXOFF" >> /home/anv1/Tools/script/minicom/conf/minirc.manual.conf
fi

echo "Serial Divices:"
dmesg | grep -e tty
echo ""
echo "Use 'man minicom' for help or 'sudo minicom -s' to setup a new profile"
echo ""
echo "Options:"
echo "1 = Serial Terminal to: Cisco, HP ProCurve, Alcatel, SUN, Nortel/Avaya" 
echo "2 = Serial Terminal to: Manual Configuration (Option 3)"
echo "3 = Manual Configuration"
echo "4 = Manual MiniCom Setup"
echo "5 = Exit Script"
read -p "Number:" OPT
if [ "$OPT" = "1" ]; then sudo minicom /home/anv1/Tools/script/minicom/conf/minirc.base.conf ; fi
if [ "$OPT" = "2" ]; then sudo minicom /home/anv1/Tools/script/minicom/conf/minirc.manual.conf ; fi
if [ "$OPT" = "4" ]; then sudo minicom -s ; fi
if [ "$OPT" = "5" ]; then exit ; fi