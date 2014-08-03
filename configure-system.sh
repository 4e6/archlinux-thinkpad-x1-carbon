#!/usr/bin/env bash

set -e

confscript="$(basename "$0")"

usage () {
  echo >&2 "Set of scripts to configure system."
  echo >&2 "Usage: $confscript <username>"
  exit 1
}

# exit_msg reson code
exit_msg () {
  if [[ "$2" -eq "0" ]]; then
    echo $1
  else
    echo >&2 $1
  fi

  exit $2
}

initialize () {
  user=$1

  [[ -z $user ]] && usage

  echo "user=$user"
  echo -n "Continue (y/n)"
  read -n 1 answer

  [[ $answer != "y" ]] && exit_msg 'exiting' 0

  echo 'configured'
}

# System setup
configure_system () {
  echo "systemctl"
  echo "enable urxvtd@${user}.service"
  systemctl enable urxvtd@${user}.service
}

initialize $@
