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
  echo -e

  [[ $answer != "y" ]] && exit_msg "exiting" 0

  configure_packages
  configure_system
  configure_manual

  echo 'configured'
}

configure_packages () {
  echo "installing packages"
  echo "base"
  pacman -Sy \
    base-devel \
    btrfs-progs \
    xorg-server \
    xorg-server-utils \
    xf86-video-intel \
    xf86-input-synaptics \
    xorg-xinit \
    xterm \
    i3 \
    alsa-utils \
    ntp \
    tlp \
    smartmontools \
    zsh \
    chromium \
    vim \
    yaourt \
    rxvt-unicode \
    urxvt-perls \
    git \
    atool \
    zip \
    unzip

  echo "aur"
  yaourt -Sy \
    aurvote \
    dmenu2 \
    xbindkeys \
    ttf-dejavu \
    ttf-ubuntu-font-family \
    ttf-freefont \
    ttf-arphic-uming \
    ttf-baekmuk \
    freetype2-ubuntu \
    fontconfig-ubuntu \
    cairo-ubuntu \
    lxappearance \
    gnome-themes-standard \
    zukitwo-themes \
    chromium-pepper-flash \
    jdk
}

# System setup
configure_system () {
  echo "systemctl"
  echo "enable urxvtd@${user}.service"
  systemctl enable urxvtd@${user}.service
}

configure_manual () {
  echo "manual configuration:"
  echo "lxappearance"
  echo "  theme: zukitwo-themes"
}

initialize $@
