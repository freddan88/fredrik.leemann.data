#!/usr/bin/env bash

case "${1}" in
mount)
    # idevicepair list
    # idevicepair pair
    # idevicepair unpair
    # idevicepair validate
    ifuse "$HOME/.local/mnt"

    ;;
umount)
    fusermount -u "$HOME/.local/mnt"
    ;;
*)
    echo "Usage:"
    echo " "
    echo "> $0 mount"
    echo "- This command mounts you iPhone at: $HOME/Media/iPhone"
    echo " "
    echo "> $0 umount"
    echo "- This command umounts you iPhone at: $HOME/Media/iPhone"
    echo " "
    ;;
esac
