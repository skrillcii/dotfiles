#!/bin/bash

#############################
# Development Installations #
#############################

install_essentials() {
    echo -e "\n >>> Essentials Installation Started..."
    # Install Xcode CLT
    xcode-select --install
    # Install Rosetta
    softwareupdate --install-rosetta --agree-to-license
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo -e " <<< Essentials Installation Finished!"
}

install_terminal_utilities() {
    echo -e "\n >>> Terminal Utilities Installation Started..."
    # Install
    brew install zsh tmux vim ranger \
                 git wget curl tree eza bat jq \
                 htop glances watch trash-cli
    # brew install autojump universal-ctags
    echo -e " <<< Terminal Utilities Installation Finished!"
}

install_desktop_applications() {
    echo -e "\n >>> Desktop Applications Installation Started..."
    # Install
    brew install --cask google-chrome firefox spotify vlc \
                        iterm2 docker visual-studio-code notion drawio \
                        steam battle-net
    echo -e " <<< Desktop Applications Installation Finished!"
}

install_iterm2_color_scheme() {
    echo -e "\n >>> iTerm2 Color Scheme Installation Started..."
    # Install nerd-fonts
    brew install --cask font-hack-nerd-font
    # Clone
    git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/iTerm2-Color-Schemes
    # Install theme
    cd ~/iTerm2-Color-Schemes
    ./tools/import-scheme.sh 'schemes/Gruvbox Dark.itermcolors'
    ./tools/import-scheme.sh 'schemes/Gruvbox Light.itermcolors'
    echo -e " <<< iTerm2 Color Scheme Installation Finished!"
}

install_oh_my_zsh() {
    echo -e "\n >>> Oh-my-zsh Installation Started..."
    # Download and install
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Download plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
    git clone https://github.com/esc/conda-zsh-completion.git ~/.oh-my-zsh/custom/plugins/conda-zsh-completion
    # Download themes
    curl -L https://raw.githubusercontent.com/sbugzu/gruvbox-zsh/master/gruvbox.zsh-theme > ~/.oh-my-zsh/custom/themes/gruvbox.zsh-theme
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
    ln -sf ~/dotfiles/zsh/zshlc ~/.zshlc
    ln -sf ~/dotfiles/zsh/p10k.zsh ~/.p10k.zsh
    echo -e 'created symbolic links!'
    echo -e " <<< Oh-my-zsh Installation Finished!"
}

install_oh_my_tmux() {
    echo -e "\n >>> Oh-my-tmux Installation Started..."
    # Download
    git clone https://github.com/gpakosz/.tmux.git ~/.oh-my-tmux
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/.oh-my-tmux/.tmux.conf ~/.tmux.conf
    ln -sf ~/dotfiles/tmux/tmux.conf.local ~/.tmux.conf.local
    echo -e 'created symbolic links!'
    echo -e " <<< Oh-my-tmux Installation Finished!"
}

install_ranger() {
    echo -e "\n >>> Ranger Installation Started..."
    # Check if configuration directory exists
    # Create if it does not exist
    echo -e 'creating directory...'
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
    echo -e 'created symbolic links!'
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

install_nvm() {
    echo -e "\n >>> Nvm Installation Started..."
    # Download
    brew install nvm
    # Export (included in .zshrc)
    export NVM_DIR="/opt/homebrew/opt/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm install v20.19.6
    echo -e " <<< Nvm Installation Finished!"
}

install_neovim() {
    echo -e "\n >>> Neovim Installation Started..."
    # Install
    brew install neovim ripgrep fd lazygit
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/nvim ~/.config/nvim
    ln -sf ~/dotfiles/stylua ~/.config/stylua
    echo -e 'created symbolic links!'
    echo -e " <<< Neovim Installation Finished!"
}

install_anaconda(){
    echo -e "\n >>> Anaconda Installation Started..."
    # Install
    brew install --cask anaconda
    # Export (included in .zshrc)
    # echo 'export PATH="/opt/homebrew/anaconda3/bin:$PATH"' >> ~/.zshrc
    echo -e " <<< Anaconda Installation Finished!"
}

install_aerospace(){
    echo -e "\n >>> Aerospace Installation Started..."
    # Install aerospace
    brew install --cask nikitabobko/tap/aerospace
    # Check if configuration directory exists
    # Create if it does not exist
    echo -e 'creating directory...'
    if [[ ! -e ~/.config/aerospace ]] ; then
        mkdir -p ~/.config/aerospace
    fi
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
    echo -e 'created symbolic links!'
    echo -e " <<< Aerospace Installation Finished!"
}

##########################
# Deprecated Development #
##########################

install_pip_packages() {
    echo -e "\n >>> Pip Package Installation Started..."
    # Install python
    pyenv install 3.10.9
    pyenv global 3.10.9 system
    # Install packages
    pip3 install -U pip pip-autoremove pylint flake8 autopep8 yapf black ipdb pdbpp
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/pdb/pdbrc.py ~/.pdbrc.py
    echo -e 'created symbolic links!'
    echo -e " <<< Pip Package Installation Finished!"
}


install_cpp(){
    echo -e "\n >>> CoC Installation Started..."
    # Install compilers and debuggers
    brew install llvm lldb clang clang-format clangd gcc g++ \
    # Add foramtter configurations
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/coc/clang-format-macos.yml ~/.clang-format
    echo -e 'created symbolic links!'
    echo -e " <<< CoC Installation Finished!"
}

##################
# Functions Call #
##################
# brew update && brew upgrade

# install_essentials
# install_terminal_utilities
# install_desktop_applications
# install_iterm2_color_scheme
# install_oh_my_zsh
# install_oh_my_tmux
# install_ranger
# install_fzf
# install_nvm
# install_neovim
# install_anaconda
# install_aerospace

# install_pip_packages
# install_cpp
