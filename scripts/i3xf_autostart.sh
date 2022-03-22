#!/usr/bin/env bash

mkdir -p /tmp/i3xf_autostart

if [[ $(lsb_release -is) == "Debian" ]]; then
  # Autostart applications for Debian
fi

if [[ $(lsb_release -is) == "Ubuntu" ]]; then
  # Autostart applications for Ubuntu
fi
