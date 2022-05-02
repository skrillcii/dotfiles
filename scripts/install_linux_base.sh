#!/usr/bin/bash

#########################
# Functions Definitions #
#########################

install_ubuntu_general() {
    echo -e "\n >>> General Installation Started..."
    # Install terminal utilities
    sudo apt install -y zsh tmux vim ranger autojump ripgrep \
                        wget curl git exuberant-ctags tree jq \
                        htop glances trash
    # Install network utilities
    sudo apt install -y net-tools nmap
    # Install fcitx
    sudo apt install -y fcitx-bin fcitx-chewing fcitx-mozc fcitx-googlepinyin
    # Git global settings
    git config --global core.excludesfile ~/dotfiles/.gitignore
    git config --global diff.tool vimdiff
    git config --global difftool.prompt false
    git config --global merge.tool vimdiff
    git config --global mergetool.prompt false
    git config --global pull.ff only
    echo -e " <<< General Installation Finished!"
}

install_nerd_fonts() {
    echo -e "\n >>> Nerd-fonts Installation Started..."
    # Download
    cur_version=`git --version | awk '{{ print $3 }}'`
    req_version='2.26.0'
    if [[ "$(printf '%s\n' "$req_version" "$cur_version" | sort -V | head -n1)" = "$req_version" ]]; then
        echo "Current git version is $cur_version, greater than required version $req_version"
        # Clone specified fonts
        git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts ~/nerd-fonts
        cd ~/nerd-fonts
        git sparse-checkout add patched-fonts/Hack
    else
        # Clone all fonts
        echo "Current git version is $cur_version, less than required version $req_version"
        git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/nerd-fonts
    fi
    # Install
    # ~/nerd-fonts/install.sh Hack
    # Clean-up
    # rm -rf ~/near-fonts
    echo -e " <<< Nerd-fonts Installation Finished!"
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
    # Source configurations
    echo 'source ~/dotfiles/zsh/zshrc' >> ~/.zshrc
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
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    # Install
    source ~/.nvm/nvm.sh
    source ~/.profile
    source ~/.bashrc
    nvm install v17.9.0
    echo -e " <<< Nvm Installation Finished!"
}

install_pyenv() {
    echo -e "\n >>> Pyenv Installation Started..."
    # Install pyenv dependcies
    sudo apt install -y make build-essential libssl-dev zlib1g-dev \
                        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
                        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    # Download pyenv
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    # Download pyenv-virtualenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    # Environment variables settings
    echo -e 'exporting environmental variabls...'
    echo 'export PYENV_ROOT="~/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
    # Install python with --enable-shared
    env PYTHON_CONFIGURE_OPTS="--enable-shared" ~/.pyenv/bin/pyenv install 3.8.6
    # Install packages
    ~/.pyenv/bin/pyenv global 3.8.6 system
    ~/.pyenv/shims/pip3 install -U pip pip-autoremove autopep8 pylint flake8 yapf ipdb pdbpp
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/pdb/pdbrc.py ~/.pdbrc.py
    echo -e " <<< Pyenv Installation Finished!"
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
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/coc/coc.vim ~/.config/coc/coc.vim
    ln -sf ~/dotfiles/coc/coc-settings.json ~/.vim/coc-settings.json
    ln -sf ~/dotfiles/coc/python.snippets ~/.config/coc/ultisnips/python.snippets
    echo -e " <<< CoC Installation Finished!"
}

##################
# Functions Call #
##################
sudo apt update && sudo apt upgrade -y
install_ubuntu_general
install_nerd_fonts
install_oh_my_zsh
install_oh_my_tmux
install_ranger
install_fzf
install_nvm
install_pyenv
install_vim_plugin_manager
install_coc
sudo apt autoremove
