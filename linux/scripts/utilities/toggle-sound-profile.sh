#!/usr/bin/env bash

sound_card="alsa_card.pci-0000_0e_00.4"

sound_profile_01="output:analog-stereo+input:analog-stereo" # Analog 3.5mm Audio Profile
sound_profile_02="output:iec958-stereo+input:analog-stereo" # Digital SDPIF Audio Profile

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

###########################################################################################################################
active_profile=$(pacmd list-cards | grep -A40 $sound_card | grep 'active profile' | awk '{print $3}' | sed -r 's/[<>]+//g')

if [ "$active_profile" = "$sound_profile_01" ]; then
  pactl set-card-profile $sound_card $sound_profile_02
else
  pactl set-card-profile $sound_card $sound_profile_01
fi
