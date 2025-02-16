#!/bin/bash

#########################
# Functions Definitions #
#########################

install_macos_general() {
    echo -e "\n >>> General Installation Started..."
    # Install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Install terminal utilities
    brew install zsh tmux vim ranger autojump ripgrep fzf imagemagick \
                 wget curl git universal-ctags tree jq \
                 lsd bat htop glances watch trash-cli
    # Install pyenv dependcies
    brew install openssl readline sqlite3 xz zlib \
                 pyenv pyenv-virtualenv rbenv ruby-build tfenv
    # Install desktop utilities
    brew install --cask google-chrome firefox spotify vlc \
                        iterm2 docker visual-studio-code notion drawio
    # Install nerd-fonts
    brew install --cask font-hack-nerd-font
    # Install financial tools
    brew install cointop
    # Git global settings
    git config --global core.excludesfile ~/dotfiles/.gitignore
    git config --global diff.tool vimdiff
    git config --global difftool.prompt false
    git config --global merge.tool vimdiff
    git config --global mergetool.prompt false
    git config --global pull.ff only
    echo -e " <<< General Installation Finished!"
}

install_iterm2_color_scheme() {
    echo -e "\n >>> iTerm2 Color Scheme Installation Started..."
    # Clone
    git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/iTerm2-Color-Schemes
    # Install theme
    cd ~/iTerm2-Color-Schemes
    ./tools/import-scheme.sh 'schemes/GruvboxDark.itermcolors'
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
    # Download themes
    curl -L https://raw.githubusercontent.com/sbugzu/gruvbox-zsh/master/gruvbox.zsh-theme > ~/.oh-my-zsh/custom/themes/gruvbox.zsh-theme
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
    ln -sf ~/dotfiles/zsh/p10k.zsh ~/.p10k.zsh
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
    # Install
    export NVM_DIR="/opt/homebrew/opt/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm install v20.18.1
    echo -e " <<< Nvm Installation Finished!"
}

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
    echo -e " <<< Pip Package Installation Finished!"
}

install_vim_plugin_manager() {
    echo -e "\n >>> Vim-plugin-manager Installation Started..."
    # Download
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
    # Install plugins, ignore intermediate error and warnings
    vim -E -s -u "~/.vimrc" +PlugInstall +qall || true
    # Install code-minimap
    brew install code-minimap
    echo -e " <<< Vim-plugin-manager Installation Finished!"
}

install_coc() {
    echo -e "\n >>> CoC Installation Started..."
    # Check if configuration directory exists
    # Create if it does not exist
    echo -e 'creating directory...'
    if [[ ! -e ~/.config/coc ]] ; then
        mkdir -p ~/.config/coc
    fi
    # Check if configuration directory exists
    # Create if it does not exist
    echo -e 'creating directory...'
    if [[ ! -e ~/.config/coc/ultisnips ]] ; then
        mkdir -p ~/.config/coc/ultisnips
    fi
    # Check if configuration directory exists
    # Create if it does not exist
    echo -e 'creating directory...'
    if [[ ! -e ~/.vim/syntax ]] ; then
        mkdir -p ~/.vim/syntax
    fi
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/coc/coc.vim ~/.config/coc/coc.vim
    ln -sf ~/dotfiles/coc/coc-settings.json ~/.vim/coc-settings.json
    ln -sf ~/dotfiles/coc/python.snippets ~/.config/coc/ultisnips/python.snippets
    ln -sf ~/dotfiles/coc/proto.vim ~/.vim/syntax/proto.vim
    echo -e " <<< CoC Installation Finished!"
}

install_cpp(){
    echo -e "\n >>> CoC Installation Started..."
    # Install compilers and debuggers
    brew install llvm lldb clang clang-format clangd gcc g++ \
    # Add foramtter configurations
    ln -sf ~/dotfiles/coc/clang-format-macos.yml ~/.clang-format
    echo -e " <<< CoC Installation Finished!"
}

install_aerospace(){
    echo -e "\n >>> Aerospace Installation Started..."
    # Install aerospace
    brew install --cask nikitabobko/tap/aerospace
    # Create symbolic links
    ln -sf ~/dotfiles/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
    echo -e " <<< Aerospace Installation Finished!"
}

##################
# Functions Call #
##################
# brew update && brew upgrade
# install_macos_general
# install_iterm2_color_scheme
# install_oh_my_zsh
# install_oh_my_tmux
# install_ranger
# install_fzf
# install_nvm
# install_pip_packages
# install_vim_plugin_manager
# install_coc
# install_cpp
# install_aerospace
