xrandr_command=$(cat $HOME/.config/autostart/lxrandr-autostart.desktop | grep Exec | cut -d"'" -f2)
$xrandr_command
