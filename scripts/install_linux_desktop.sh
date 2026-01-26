#!/bin/bash

#####################
# General Utilities #
#####################

install_ubuntu_general() {
    echo -e "\n >>> General Installation Started..."
    # Install general
    sudo apt install -y vlc chromium-browser gnome-shell-extension-manager chrome-gnome-shell
    echo -e " <<< General Installation Finished!"
}

install_docker() {
    echo -e "\n >>> Docker Installation Started..."
    # Download installation script
    git clone https://github.com/docker/docker-install.git ~/docker-install
    # Install
    sh ~/docker-install/install.sh
    # Test
    sudo docker run hello-world
    # Clean
    rm -rf ~/docker-install
    echo -e " <<< Docker Installation Finished!"
}

install_nvidia_driver() {
    echo -e "\n >>> NVIDIA Driver Installation Started..."
    # Install
    sudo apt install -y `ubuntu-drivers devices | grep recommended | awk '{{ print $3 }}'`
    echo -e " <<< NVIDIA Driver Installation Finished!"
}

install_nvidia_container_toolkit() {
    echo -e "\n >>> NVIDIA Container Toolkit Installation Started..."
    # Install dependencies
    sudo apt-get update && sudo apt-get install -y --no-install-recommends curl gnupg2
    # Add GPG key
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
    sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    # Update
    sudo apt-get update
    # Install
    sudo apt-get install -y nvidia-container-toolkit
    # Configure
    sudo nvidia-ctk runtime configure --runtime=docker
    # Restart
    sudo systemctl restart docker
    # Verify
    sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
    echo -e " <<< NVIDIA Container Toolkit Installation Finished!"
}

install_nvidia_cuda_toolkit() {
    echo -e "\n >>> NVIDIA CUDA Toolkit Installation Started..."
    # Follow offical documentation
    # https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#
    echo -e " <<< NVIDIA CUDA Toolkit Installation Finished!"
}

#########################
# Development Utilities #
#########################

install_cpp() {
    echo -e "\n >>> CPP Installation Started..."
    # Install compilers and debuggers
    sudo apt install -y clang clang-format clang-tidy clangd \
                        gcc g++ gdb libstdc++-12-dev llvm lldb \
    # Add debugger configurations
    ln -sf ~/dotfiles/gdb/gdbinit ~/.gdbinit
    # Add foramtter configurations
    ln -sf ~/dotfiles/coc/clang-format-ubuntu.yml ~/.clang-format
    # Install python dependcies for gdb
    ~/.pyenv/shims/pip3 install --use-feature=2020-resolver \
        -U pygments
    echo -e " <<< CPP Installation Finished!"
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
    sudo snap install spotify
    echo -e " <<< Spotify Installation Finished!"
}

install_screenkey() {
    echo -e "\n >>> Screenkey Installation Started..."
    sudo apt install -y screenkey
    echo -e " <<< Screenkey Installation Finished!"
}

#######################
# Financial Utilities #
#######################

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

#########################
# Engineering Utilities #
#########################

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
# sudo apt update
# sudo apt upgrade -y
# sudo apt autoremove -y

# install_ubuntu_general
# install_docker
# install_nvidia_driver
# install_nvidia_container_toolkit
# install_nvidia_cuda_toolkit

# install_cpp
# install_java
# install_gvm
# install_tfenv

# install_spotify
# install_screenkey

# install_cointop
# install_mop
# install_ticker

# install_mechatronics
# install_drawio

# sudo apt update
# sudo apt upgrade -y
# sudo apt autoremove -y
