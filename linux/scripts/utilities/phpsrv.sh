#!/usr/bin/env bash

lan_port=8000

################################
# DO NOT EDIT BELOW THIS LINE! #
################################

function stop_previous_instance {
  previus_pid=$(netstat -ltnp 2>/dev/null | grep 0.0.0.0:$lan_port | awk '{print $7}' | cut -d'/' -f1)

  if [[ -n "${previus_pid}" ]]; then
    kill -9 "$previus_pid"
  fi
}

function start_new_instance {
  php -S 0.0.0.0:$lan_port >/dev/null &
  php_server_pid=$!

  soc1="127.0.0.1:$lan_port"
  soc2="localhost:$lan_port"

  echo " "
  echo "PHP Server version 2.5.2 Linux"
  echo " "
  echo "Server listening on all interfaces including:"
  echo "---------------------------------------------"

  echo " "
  echo "- $soc1"
  echo "- $soc2"
  echo " "

  echo "Server started on port: $lan_port using pid: $php_server_pid"
  echo " "

  echo "You can run 'phpsrv kill' to stop stale instances of this server"
  echo " "

  xdg-open http://"$soc1" 2>/dev/null

  trap stop_previous_instance EXIT
}

case $1 in
kill)
  stop_previous_instance
  ;;
*)
  stop_previous_instance
  start_new_instance
  ;;
esac
