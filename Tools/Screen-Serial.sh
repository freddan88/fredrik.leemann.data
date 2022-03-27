serial=/dev/ttyS0
speed=9600
echo "Serial Divices:"
dmesg | grep -e tty
echo ""
echo "This Serial connection will work for Cisco/HP and more"
echo""
sudo screen $serial $speed
