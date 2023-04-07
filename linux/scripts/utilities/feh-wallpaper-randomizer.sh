#!/usr/bin/env bash

# CONFIGURATION
###############

# WALLPAPER IMAGE DIRECTORY
directory="/usr/share/wallpapers"

# WALLPAPER IMAGE MODE
# MODES: center|fill|max|scale|tile
mode="fill"

# WALLPAPER IMAGE CHANGE INTERVAL
interval=300

# DO NOT EDIT BELOW THIS LINE
#############################

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
