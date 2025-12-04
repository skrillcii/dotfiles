#!/bin/bash

#############################
# Development Installations #
#############################

install_ubuntu_general() {
    echo -e "\n >>> General Installation Started..."
    # Install general
    sudo apt install -y vlc chromium-browser gnome-shell-extension-manager chrome-gnome-shell
    # Install specifics
    sudo apt install -y powertop mesa-utils lm-sensors sensors-detect 
    echo -e " <<< General Installation Finished!"
}

install_docker() {
    echo -e "\n >>> Docker Installation Started..."
    # Uninstall old versions
    sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
    # Add Docker's official GPG key
    sudo apt update
    sudo apt install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    # Add the repository
    echo " Types: deb\nURIs: https://download.docker.com/linux/ubuntu\nSuites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")\nComponents: stable\nSigned-By: /etc/apt/keyrings/docker.asc\nArchitectures: amd64" \ 
        | sudo tee /etc/apt/sources.list.d/docker.sources 
    sudo apt update
    # Install
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    # Verify
    sudo systemctl restart docker
    sudo docker run hello-world
    echo -e " <<< Docker Installation Finished!"
}

install_nvidia_driver() {
    echo -e "\n >>> NVIDIA Driver Installation Started..."
    # Install
    sudo apt install -y `ubuntu-drivers devices | grep recommended | awk '{{ print $3 }}'`
    echo -e " <<< NVIDIA Driver Installation Finished!"
}

install_nvidia_container_toolkit() {
    echo -e "\n >>> NVIDIA Docker Installation Started..."
    # Install dependencies
    sudo apt-get update && sudo apt-get install -y --no-install-recommends curl gnupg2
    # Add GPG key
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
        | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
        && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
        | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
        | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    sudo apt-get update
    # Install
    export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.18.0-1
    sudo apt-get install -y \
        nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
        nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
        libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
        libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}
    # Configure
    sudo nvidia-ctk runtime configure --runtime=docker
    # Verify
    sudo systemctl restart docker
    sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
    echo -e " <<< NVIDIA Docker Installation Finished!"
}

install_java() {
    echo -e "\n >>> Java Installation Started..."
    # Install
    sudo apt install -y default-jre default-jdk maven
    echo -e " <<< Java Installation Finished!"
}

install_gvm() {
    echo -e "\n >>> Gvm Installation Started..."
    # Install dependcies
    sudo apt install bison
    # Install gvm
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    # Install golang (using binary option -B)
    gvm install go1.23.4 -B
    # Set golang
    gvm use go1.23.4 --default
    echo -e " <<< Gvm Installation Finished!"
}

install_tfenv(){
    echo -e "\n >>> Tfenv Installation Started..."
    # Download
    git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
    # Create symbolic link
    sudo ln -sf ~/.tfenv/bin/* /usr/local/bin/
    echo -e " <<< Tfenv Installation Finished!"
}

#####################
# Desktop Utilities #
#####################

install_spotify(){
    echo -e "\n >>> Spotify Installation Started..."
    # From official release
    # Reference: https://www.spotify.com/us/download/linux/
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update && sudo apt install -y spotify-client
    echo -e " <<< Spotify Installation Finished!"
}

install_zsa(){
    echo -e "\n >>> Moonlander Installation Started..."
    # Install dependcies
    # Currently, only cli dependency is listed here
    sudo apt install -y libusb-dev
    # Download wally binary version 'gui' or 'cli'
    # Currently only wally-cli is used and is already provided in dotfiles
    # cd ~ && wget https://configure.ergodox-ez.com/wally/linux
    # cd ~ && wget https://github.com/zsa/wally-cli/releases/download/2.1.3-linux/wally
    # cd ~ && wget https://github.com/zsa/wally-cli/releases/download/2.0.0-linux/wally-cli
    # Low-level device communication kernel scripts
    sudo ln -s -f ~/dotfiles/zsa/50-oryx.rules /etc/udev/rules.d/
    sudo ln -s -f ~/dotfiles/zsa/50-wally.rules /etc/udev/rules.d/
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
    ln -sf ~/.config/i3/bumblebee-status/bumblebee-status ~/.config/i3/bumblebee-status/bumblebee-status.py
    ln -sf ~/dotfiles/i3/i3main.conf ~/.config/i3/config/
    ln -sf ~/dotfiles/i3/i3status.conf ~/.i3status.conf
    sudo ln -sf ~/dotfiles/i3/i3exit.sh /usr/local/bin/i3exit
    echo -e " <<< I3wm Installation Finished!"
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

###################
# Financial Tools #
###################

install_cointop() {
    echo -e "\n >>> Cointop Installation Started..."
    # Check golang version
    cur_version=`go version | awk '{{ print $3 }}'`
    req_version='go1.17.0'
    if [[ "$(printf '%s\n' "$req_version" "$cur_version" | sort -V | head -n1)" = "$req_version" ]]; then
        echo "Current golang version is $cur_version, greater than required version $req_version."
        echo "Installation started..."
        # Install
        go install github.com/cointop-sh/cointop@latest
    else
        echo "Current golang version is $cur_version, less than required version $req_version."
        echo "Installation terminated."
    fi
    echo -e " <<< Cointop Installation Finished!"
}

install_mop() {
    echo -e "\n >>> Mop Installation Started..."
    # Download
    git clone https://github.com/mop-tracker/mop ~/mop
    # Build
    cd ~/mop && go build ./cmd/mop
    # Install
    cd ~/mop/cmd/mop && go install
    # Install
    cd ~ && rm -rf ~/mop
    # Keybindings
    # +   Add stocks to the list.
    # -   Remove stocks from the list.
    # o   Change column sort order.
    # g   Group stocks by advancing/declining issues.
    # f   Set a filtering expression.
    # F   Unset a filtering expression.
    # ?   Display help screen.
    # esc Quit mop.
    echo -e " <<< Mop Installation Finished!"
}

install_ticker() {
    echo -e "\n >>> Ticker Installation Started..."
    curl -Ls https://api.github.com/repos/achannarasappa/ticker/releases/latest \
        | grep -wo "https.*linux-amd64*.tar.gz" \
        | wget -qi - \
        && tar -xvf ticker*.tar.gz ticker \
        && rm ticker*.tar.gz \
        && chmod +x ./ticker \
        && sudo mv ticker /usr/local/bin/
    # Create symbolic links
    ln -sf ~/dotfiles/ticker/ticker.yaml ~/.ticker.yaml
    echo -e " <<< Ticker Installation Finished!"
}

#####################
# Engineering Tools #
#####################

install_mechatronics() {
    echo -e "\n >>> Mechatronics Installation Started..."
    sudo apt install -y kicad kicad-packages3d openscad freecad blender libreoffice
    echo -e " <<< Mechatronics Installation Finished!"
}

install_drawio() {
    echo -e "\n >>> Drawio Installation Started..."
    # release notes: https://github.com/jgraph/drawio-desktop/releases/
    wget https://github.com/jgraph/drawio-desktop/releases/download/v24.1.0/drawio-amd64-24.1.0.deb
        -P $home/Downloads
    sudo apt install $home/Downloads/drawio-amd64-21.7.5.deb
    rm $home/Downloads/drawio-amd64-21.7.5.deb
    echo -e " <<< Drawio Installation Finished!"
}

#################
# Function Call #
#################
sudo apt update && sudo apt upgrade -y

# install_ubuntu_general
# install_docker
# install_nvidia_driver
# install_nvidia_container_toolkit

# install_java
# install_gvm
# install_tfenv

# install_spotify
# install_zsa
# install_i3wm
# install_screenkey
# install_kazam
# install_ffmpeg

# install_cointop
# install_mop
# install_ticker

# install_mechatronics
# install_drawio

sudo apt autoremove -y
