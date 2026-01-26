#!/bin/bash

#############################
# Development Installations #
#############################

install_ubuntu_general() {
    echo -e "\n >>> General Installation Started..."
    # Install basics
    sudo apt install -y zsh tmux vim ranger ripgrep xsel xclip \
                        git wget curl tree eza bat jq build-essential \
                        htop nvtop glances neofetch trash-cli
    # Install network
    sudo apt install -y net-tools nmap
    # Install fcitx
    sudo apt install -y fcitx5 fcitx5-chewing fcitx5-mozc fcitx5-pinyin
    echo -e " <<< General Installation Finished!"
}

install_oh_my_zsh() {
    echo -e "\n >>> Oh-my-zsh Installation Started..."
    # Install
    sudo apt install -y zsh
    # Download and install
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Download plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
    git clone https://github.com/esc/conda-zsh-completion.git ~/.oh-my-zsh/custom/plugins/conda-zsh-completion
    # Download powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
    ln -sf ~/dotfiles/zsh/zshlc ~/.zshlc
    echo -e " <<< Oh-my-zsh Installation Finished!"
}

install_oh_my_tmux() {
    echo -e "\n >>> Oh-my-tmux Installation Started..."
    # Install
    sudo apt install -y tmux
    # Download
    git clone https://github.com/gpakosz/.tmux.git ~/.oh-my-tmux
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/.oh-my-tmux/.tmux.conf ~/.tmux.conf
    ln -sf ~/dotfiles/tmux/tmux.conf.local ~/.tmux.conf.local
    echo -e " <<< Oh-my-tmux Installation Finished!"
}

install_nerd_fonts() {
    echo -e "\n >>> Nerd-fonts Installation Started..."
    # Download
    curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
    # Create directory
    mkdir -p ~/.local/share/fonts/NerdFonts
    # Install
    unzip Hack.zip -d ~/.local/share/fonts/NerdFonts
    # Clean
    rm -rf Hack.zip
    echo -e " <<< Nerd-fonts Installation Finished!"
}

install_gogh_color_scheme() {
    echo -e "\n >>> Gogh Color Scheme Installation Started..."
    # Install dependencies
    sudo apt install dconf-cli uuid-runtime
    # Download
    git clone https://github.com/Gogh-Co/Gogh.git ~/gogh
    # Export (included in .zshrc)
    # Necessary for initial installation in the Gnome terminal on ubuntu
    export TERMINAL=gnome-terminal
    # Install theme
    ~/gogh/installs/gruvbox-dark.sh
    ~/gogh/installs/gruvbox.sh
    # Clean
    rm -rf ~/gogh
    echo -e " <<< Gogh Color Scheme Installation Finished!"
}

install_ranger() {
    echo -e "\n >>> Ranger Installation Started..."
    # Install
    sudo apt install -y ranger atool
    # Create directory if it does not exist
    echo -e 'checking directory...'
    if [[ ! -e ~/.config/ranger ]] ; then
        mkdir -p ~/.config/ranger
    fi
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/ranger/commands.py ~/.config/ranger/
    ln -sf ~/dotfiles/ranger/commands_full.py ~/.config/ranger/
    ln -sf ~/dotfiles/ranger/rc.conf ~/.config/ranger/
    ln -sf ~/dotfiles/ranger/rifle.conf ~/.config/ranger/
    ln -sf ~/dotfiles/ranger/scope.sh ~/.config/ranger/
    echo -e " <<< Ranger Installation Finished!"
}

install_fzf() {
    echo -e "\n >>> Fzf Installation Started..."
    # Download
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    # Install
    ~/.fzf/install --key-bindings --completion --no-update-rc
    echo -e " <<< Fzf Installation Finished!"
}

install_bat() {
    echo -e "\n >>> Fzf Installation Started..."
    # Download
    sudo apt install bat
    # Create symbolic links
    # This is due to a name clash with antoher package in Ubuntu.
    ln -sf /usr/bin/batcat ~/.local/bin/bat
    echo -e " <<< Fzf Installation Finished!"
}

install_lazygit() {
    echo -e "\n >>> Lazygit Installation Started..."
    # Download
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    # Extract
    tar xf lazygit.tar.gz lazygit
    # Install
    sudo install lazygit -D -t /usr/local/bin/
    # Clean
    rm -rf lazygit.tar.gz && rm -rf lazygit
    echo -e " <<< Lazygit Installation Finished!"
}

install_nvm() {
    echo -e "\n >>> Nvm Installation Started..."
    # Download
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    # Source
    source ~/.nvm/nvm.sh
    source ~/.profile
    source ~/.bashrc
    # Install
    nvm install v20.19.6
    echo -e " <<< Nvm Installation Finished!"
}

install_neovim_x86_64() {
    echo -e "\n >>> Neovim (x86_64) Installation Started..."
    # Download
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
    # Clean
    rm -rf ~/.local/share/nvim-linux-x86_64
    # Create directory if it does not exist
    echo -e 'checking directory...'
    if [[ ! -e ~/.local/bin ]] ; then
        mkdir -p ~/.config/bin
    fi
    if [[ ! -e ~/.local/share ]] ; then
        mkdir -p ~/.config/share
    fi
    # Install
    tar -C ~/.local/share/ -xzf nvim-linux-x86_64.tar.gz
    # Create symbolic links
    ln -sf ~/.local/share/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim
    ln -sf ~/dotfiles/nvim ~/.config/nvim
    ln -sf ~/dotfiles/stylua ~/.config/stylua
    # Clean
    rm -rf nvim-linux-x86_64.tar.gz
    echo -e " <<< Neovim (x86_64) Installation Finished!"
}

install_neovim_aarch64() {
    echo -e "\n >>> Neovim (aarch64) Installation Started..."
    # Download
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-arm64.tar.gz
    # Clean
    rm -rf ~/.local/share/nvim-linux-arm64
    # Create directory if it does not exist
    echo -e 'checking directory...'
    if [[ ! -e ~/.local/bin ]] ; then
        mkdir -p ~/.config/bin
    fi
    if [[ ! -e ~/.local/share ]] ; then
        mkdir -p ~/.config/share
    fi
    # Install
    tar -C ~/.local/share/ -xzf nvim-linux-arm64.tar.gz
    # Create symbolic links
    ln -sf ~/.local/share/nvim-linux-arm64/bin/nvim ~/.local/bin/nvim
    ln -sf ~/dotfiles/nvim ~/.config/nvim
    ln -sf ~/dotfiles/stylua ~/.config/stylua
    # Clean
    rm -rf nvim-linux-arm64.tar.gz
    echo -e " <<< Neovim (aarch64) Installation Finished!"
}

install_anaconda() {
    echo -e "\n >>> Anaconda Installation Started..."
    # Download
    cd $HOME
    curl -O https://repo.anaconda.com/archive/Anaconda3-2025.06-0-Linux-x86_64.sh
    # Install
    bash ~/Anaconda3-2025.06-0-Linux-x86_64.sh -b -p $HOME/anaconda3
    # Clean
    rm ~/Anaconda3-2025.06-0-Linux-x86_64.sh
    echo -e " <<< Anaconda Installation Finished!"
}

install_miniconda_x86_64() {
    echo -e "\n >>> Miniconda (x86_64) Installation Started..."
    # Download
    cd $HOME
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    # Install
    bash ~/Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
    # Clean
    rm ~/Miniconda3-latest-Linux-x86_64.sh
    echo -e " <<< Miniconda (x86_64) Installation Finished!"
}

install_miniconda_aarch64() {
    echo -e "\n >>> Miniconda (aarch64) Installation Started..."
    # Download
    cd $HOME
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh
    # Install
    bash ~/Miniconda3-latest-Linux-aarch64.sh -b -p $HOME/miniconda3
    # Clean
    rm ~/Miniconda3-latest-Linux-aarch64.sh
    echo -e " <<< Miniconda (aarch64) Installation Finished!"
}

#################
# Function Call #
#################
# sudo apt update
# sudo apt upgrade -y
# sudo apt autoremove -y

# install_ubuntu_general
# install_oh_my_zsh
# install_oh_my_tmux
# install_nerd_fonts
# install_gogh_color_scheme
# install_ranger
# install_fzf
# install_lazygit

# install_nvm
# install_neovim_x86_64
# install_neovim_aarch64
# install_anaconda
# install_miniconda_x86_64
# install_miniconda_aarch64

# sudo apt update
# sudo apt upgrade -y
# sudo apt autoremove -y
