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

# DO NOT EDIT BELOW THIS LINE
#############################

# pids=$(pgrep -f feh-wallpaper-randomizer.sh)
# $pids | xargs -r kill -9

echo ""
if [ "$(command -v feh)" ]; then
  if [ -d "$directory" ]; then
    while true; do
      for image in $directory; do
        feh --recursive --bg-$mode --randomize "$image"
        sleep $interval
      done
    done
  else
    echo "ERROR: DIRECTORY NOT FOUND"
  fi
else
  echo "ERROR: COMMAND FEH NOT FOUND"
fi
echo ""
