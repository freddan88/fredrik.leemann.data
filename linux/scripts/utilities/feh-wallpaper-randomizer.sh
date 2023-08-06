#!/usr/bin/env bash

# CONFIGURATION
###############

# WALLPAPER IMAGE DIRECTORY
directory="/home/fredrik/Pictures/wallpapers"

# WALLPAPER IMAGE MODE (MODES)
# <center|fill|max|scale|tile>
mode="scale"

# WALLPAPER IMAGE CHANGE INTERVAL (SECONDS)
interval=300

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

# GET PID LSOF EXAMPLE
# lsof | grep $0 | awk '{print $2}'

echo " "

pids=$(pgrep -f "$0")
pids_count=$(echo "$pids" | wc -l)

case "$1" in
start)
  if (("$pids_count" > 1)); then
    echo "FEH WALLPAPER RANDOMIZER IS RUNNING"
    echo "STOP THE SCRIPT USING: $0 stop"
    echo " "
    exit
  fi
  if [ "$(command -v feh)" ]; then
    if [ -d "$directory" ]; then
      while true; do
        for image in $directory; do
          feh --recursive --bg-$mode --randomize "$image"
          sleep "$interval"
        done
      done
    else
      echo "ERROR: DIRECTORY ($directory) NOT FOUND"
    fi
  else
    echo "ERROR: COMMAND FEH NOT FOUND"
  fi
  ;;
stop)
  echo "STOPPING: FEH WALLPAPER RANDOMIZER"
  echo "$pids" | xargs -r kill -9
  ;;
*)
  echo "AVAILABLE COMMANDS"
  echo "- $0 start"
  echo "- $0 stop"
  ;;
esac

echo " "
