To keep files synchronized all configs hardlinked to original system ones except `/etc/sudoers.d/` due to file permissions

    sudo cp -al --parents /etc/pacman.d/mirrorlist .
