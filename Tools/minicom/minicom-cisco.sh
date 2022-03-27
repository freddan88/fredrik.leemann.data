echo "Serial Divices:"
dmesg | grep -e tty
echo "This configuration will work for most divices etc Cisco, HP ProCurve"
cat /home/anv1/Tools/script/minicom/conf/minirc.cisco.conf
echo ""
echo "Use 'man minicom' for help or 'sudo minicom -s' to setup a new profile"
echo "Type in current password for user: $USER"
sudo minicom /home/anv1/Tools/script/minicom/conf/minirc.cisco.conf
