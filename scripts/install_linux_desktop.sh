#!/usr/bin/bash

#########################
# Functions Definitions #
#########################

install_ubuntu_general () {
    echo -e "\n >>> General Installation Started..."
    # Install desktop utilities
    sudo apt install -y vlc redshift xclip lm-sensors mesa-utils \
                        sensors-detect tfenv
    # Install fcitx
    sudo apt install -y fcitx-bin fcitx-chewing fcitx-mozc fcitx-googlepinyin
    # Install java-11
    sudo apt install -y default-jre default-jdk maven

    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -s -f ~/dotfiles/x/xprofile ~/.xprofile
    ln -s -f ~/dotfiles/redshift/redshift.conf ~/.config/redshift.conf
    echo -e " <<< General Installation Finished!"
}

install_docker() {
    echo -e "\n >>> Docker Installation Started..."
    # Uninstall old versions
    sudo apt remove -y docker docker-engine docker.io containerd runc
    # Install dependcies
    sudo apt install -y ca-certificates curl gnupg lsb-release
    # Add GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    # Setup repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    # Install
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    # Verify installation
    sudo docker run hello-world
    echo -e " <<< Docker Installation Finished!"
}

install_nvidia_driver() {
    echo -e "\n >>> Nvidia Driver Installation Started..."
    # Install
    sudo apt install -y `ubuntu-drivers devices | grep recommended | awk '{{ print $3 }}'` nvidia-cuda-toolkit
    echo -e " <<< Nvidia Driver Installation Finished!"
}

install_nvidia_docker() {
    echo -e "\n >>> Nvidia Docker Installation Started..."
    # Add GPG key
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
        && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
        sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
        && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
        sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
        sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    # Install
    sudo apt-get update
    sudo apt-get install -y nvidia-docker2
    # Restart
    sudo systemctl restart docker
    # Verify installation
    sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
    echo -e " <<< Nvidia Docker Installation Finished!"
}

install_vim_build_from_source() {
    echo -e "\n >>> Vim Installation Started..."
    # Remove old version
    sudo apt remove vim vim-runtime gvim
    # Install dependencies
    sudo apt install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
                        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
                        libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
                        python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git
    # Download
    git clone https://github.com/vim/vim.git ~/vim
    cd ~/vim
    # Use '$(python3-config --configdir)' to check for flag '--with-python3-config-dir'
    # To check python path in vim ':python3 import sys; print(sys.path)'
    make clean distclean
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-terminal \
        --enable-rubyinterp=yes \
        --enable-python3interp=yes \
        --with-python3-config-dir=$(python3-config --configdir) \
        --enable-perlinterp=yes \
        --enable-gui=gtk3 \
        --enable-cscope \
        --prefix=/usr/local \
        --enable-fail-if-missing \
    make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
    # Install
    cd ~/vim
    sudo checkinstall
    # Clean
    sudo rm -rf ~/vim
    echo -e " <<< Vim Installation Finished!"
}

install_i3wm() {
    echo -e "\n >>> I3wn Installation Started..."
    # Install
    sudo apt install -y i3 i3blocks
    # Install extensions
    sudo apt install -y imagemagick feh playerctl
    # Pip install extensions
    pip3 install psutil netifaces
    # Convert Ubuntu 20.04 default wallpaper from .jpg to .png
    convert -scale 2560x1440 /usr/share/backgrounds/matt-mcnulty-nyc-2nd-ave.jpg /usr/share/backgrounds/lockscreen.png
    # Download extensions
    git clone https://github.com/gabrielelana/awesome-terminal-fonts.git ~/awesome-terminal-fonts
    cd ~/awesome-terminal-fonts && ./install.sh
    cd .. && rm -rf ~/awesome-terminal-fonts
    git clone https://github.com/tobi-wan-kenobi/bumblebee-status.git ~/bumblebee-status
    # Check if configuration directory exists
    # Create if it does not exist
    if [[ ! -e ~/.config/i3 ]] ; then
        mkdir -p ~/.config/i3
    fi
    mv ~/bumblebee-status ~/.config/i3/bumblebee-status
    # Create symbolic links
    ln -s -f ~/.config/i3/bumblebee-status/bumblebee-status ~/.config/i3/bumblebee-status/bumblebee-status.py
    ln -s -f ~/dotfiles/i3/i3main.conf ~/.config/i3/config
    ln -s -f ~/dotfiles/i3/i3status.conf ~/.i3status.conf
    sudo ln -s -f ~/dotfiles/i3/i3exit.sh /usr/local/bin/i3exit
    echo -e " <<< I3wm Installation Finished!"
}

install_spotify(){
    echo -e "\n >>> Spotify Installation Started..."
    # From official release
    # Reference: https://www.spotify.com/us/download/linux/
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update && sudo apt install -y spotify-client
    echo -e " <<< Spotify Installation Finished!"
}

install_moonlander(){
    echo -e "\n >>> Moonlander Installation Started..."
    # Install dependcies
    # Currently, only cli dependency is listed here
    sudo apt install -y libusb-dev
    # Download wally binary version 'gui' or 'cli'
    # Currently only wally-cli is used and is already provided in dotfiles
    # cd ~ && wget https://configure.ergodox-ez.com/wally/linux
    # cd ~ && wget https://github.com/zsa/wally-cli/releases/download/2.0.0-linux/wally-cli
    # Low-level device communication kernel scripts
    sudo ln -s -f ~/dotfiles/moonlander/50-oryx.rules /etc/udev/rules.d/
    sudo ln -s -f ~/dotfiles/moonlander/50-wally.rules /etc/udev/rules.d/
    # # Check if plugdev group exists and if user is in plugdev group, if not create and add
    if [ $(getent group 'plugdev') ]; then
        echo "Group plugdev exists! Done!"
    else
        echo "Group plugdev does not exist!"
        echo "Create plugdev group..."
        sudo groupadd plugdev
        sudo usermod -aG plugdev $USER
        echo "Done!"
    fi
    echo -e " <<< Moonlander Installation Finished!"
}

install_screenkey() {
    echo -e "\n >>> Screenkey Installation Started..."
    # Install dependencies
    sudo apt install -y python3-gi gir1.2-gtk-3.0 python3-cairo \
                        python3-setuptools python3-distutils-extra \
                        fonts-font-awesome slop gir1.2-appindicator3-0.1
    # Pip install dependencies
    pip3 install vext vext.gi
    # Source screenkey v1.2 from 'https://www.thregr.org/~wavexx/software/screenkey/'
    cd ~ && wget https://www.thregr.org/~wavexx/software/screenkey/releases/screenkey-1.2.tar.gz
    tar -xvf ~/screenkey-1.2.tar.gz
    rm -rf ~/screenkey-1.2.tar.gz
    mv ~/screenkey-1.2 ~/.config
    # Portable without installation (preferred way of using)
    # sudo ./screenkey
    # Set alias (e.g configure in .zshrc)
    # sudo screenkey
    # Install & uninstall onto system
    # sudo ~/screenkey-1.2/setup.py install --record files.txt
    # cat files.txt | xargs sudo rm -rf
    echo -e " <<< Screenkey Installation Finished!"
}

install_kazam() {
    echo -e "\n >>> Kazam Installation Started..."
    # Install
    sudo apt install -y kazam
    # Keybindings
    # Super key + CTRL + R = Start recording.
    # Super key + CTRL + P = Pause recording, press again to resume.
    # Super key + CTRL + F = Finish recording.
    # Super key + CTRL + Q = Quit recording.
    echo -e " <<< Kazam Installation Finished!"
}

install_ffmpeg() {
    echo -e "\n >>> Ffmpeg Installation Started..."
    # Install
    sudo apt install -y ffmpeg
    # Example usage for video compression
    # ffmpeg -i input.mp4 output.mp4
    echo -e " <<< Ffmpeg Installation Finished!"
}

##################
# Functions Call #
##################
sudo apt update && sudo apt upgrade -y
install_docker
install_nvidia_driver
install_nvidia_docker
install_vim_build_from_source
install_i3wm
install_spotify
install_moonlander
install_screenkey
install_kazam
install_ffmpeg
sudo apt autoremove
