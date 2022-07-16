#
# Change autostart_x to start X automatically (1/0)
autostart_x=0

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
if [ -d "$NVM_DIR" ]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
fi

xstarted=$(ps -e | grep -c Xorg)

if ((xstarted == 0)); then
  echo " "
  if ((autostart_x)); then
    startx
  else
    echo "PRESS ENTER TO START X OR CTRL+C TO EXIT - YOU CAN START X WITH THE COMMAND: startx"
    read key
    startx
  fi
else
  echo " "
  if [ "$(command -v xdotool)" ] && [ "$(command -v neofetch)" ]; then
    currentPid=$(xdotool getactivewindow getwindowpid)
    currentProgram=$(ps -o command= $currentPid)
    if [ "$currentProgram" = "xfce4-terminal" ]; then
      neofetch
      echo "Codename: $(lsb_release -cs)"
      echo " "
    fi
  fi
fi
