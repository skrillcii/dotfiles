#!/bin/bash

########################
# Function Definitions #
########################

install_ubuntu_general() {
    echo -e "\n >>> General Installation Started..."
    # Install terminal utilities basics
    sudo apt install -y zsh tmux vim ranger \
                        git wget curl tree exa bat \
                        htop nvtop neofetch trash-cli
    # Install terminal utilities advance
    sudo apt install -y autojump ripgrep xsel xclip \
                        jq gh glances
    # Install network utilities
    sudo apt install -y net-tools nmap
    # Install fcitx
    sudo apt install -y fcitx5 fcitx5-chewing fcitx5-mozc fcitx5-pinyin
    # Git global settings
    git config --global core.excludesfile ~/dotfiles/.gitignore
    git config --global diff.tool vimdiff
    git config --global difftool.prompt false
    git config --global merge.tool vimdiff
    git config --global mergetool.prompt false
    git config --global pull.ff only
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
    # Download themes (Deprecated)
    # curl -L https://raw.githubusercontent.com/sbugzu/gruvbox-zsh/master/gruvbox.zsh-theme > ~/.oh-my-zsh/custom/themes/gruvbox.zsh-theme
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
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
    curl --output-dir ~/Downloads -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz
    # Create directory
    mkdir -p ~/.local/share/fonts/NerdFonts
    # Install fonts
    tar -xvf ~/Downloads/Hack.tar.xz
    mv ~/Downloads/Hack/* ~/.local/share/fonts/NerdFonts
    # Clean-up
    rm -rf ~/Downloads/Hack
    rm -rf ~/Downloads/Hack.tar.xz
    echo -e " <<< Nerd-fonts Installation Finished!"
}

install_gogh_color_scheme() {
    echo -e "\n >>> Gogh Color Scheme Installation Started..."
    # Install dependencies
    sudo apt install dconf-cli uuid-runtime
    # Download
    git clone https://github.com/Gogh-Co/Gogh.git ~/gogh
    # Necessary in the Gnome terminal on ubuntu
    export TERMINAL=gnome-terminal
    # Install theme
    ~/gogh/installs/gruvbox-dark.sh
    echo -e " <<< Gogh Color Scheme Installation Finished!"
}

install_ranger() {
    echo -e "\n >>> Ranger Installation Started..."
    # Install
    sudo apt install -y ranger atool
    # Check if configuration directory exists
    # Create if it does not exist
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

install_nvm() {
    echo -e "\n >>> Nvm Installation Started..."
    # Download
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    # Source
    source ~/.nvm/nvm.sh
    source ~/.profile
    source ~/.bashrc
    # Install
    nvm install v20.12.1
    echo -e " <<< Nvm Installation Finished!"
}

install_anaconda() {
    echo -e "\n >>> Anaconda Installation Started..."
    # Download
    cd $HOME
    curl -O https://repo.anaconda.com/archive/Anaconda3-2025.06-0-Linux-x86_64.sh
    # Install
    bash ~/Anaconda3-2025.06-0-MacOSX-x86_64.sh -b -p $HOME/anaconda3
    echo -e " <<< Anaconda Installation Finished!"
}

install_pyenv() {
    echo -e "\n >>> Pyenv Installation Started..."
    # Install pyenv dependcies
    sudo apt install -y build-essential libssl-dev zlib1g-dev \
                        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
                        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    # Download pyenv
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    # Download pyenv-virtualenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    # Environment variables settings
    echo -e 'exporting environmental variabls...'
    echo -e 'export PYENV_ROOT="~/.pyenv"' >> ~/.bashrc
    echo -e 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'eval "$(pyenv init -)"' >> ~/.bashrc
    # Install python with --enable-shared
    env PYTHON_CONFIGURE_OPTS="--enable-shared" ~/.pyenv/bin/pyenv install 3.10.8
    # Install python packages
    ~/.pyenv/bin/pyenv global 3.10.8 system
    ~/.pyenv/shims/pip3 install --use-feature=2020-resolver \
        -U pip pip-autoremove pylint flake8 autopep8 yapf black ipdb pdbpp
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/pdb/pdbrc.py ~/.pdbrc.py
    echo -e " <<< Pyenv Installation Finished!"
}

install_vim_plugin_manager() {
    echo -e "\n >>> Vim-plugin-manager Installation Started..."
    # Install
    sudo apt install -y vim
    # Download
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    # Create symbolic links
    echo -e 'creating symbolic links...'
    ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
    # Install plugins, ignore intermediate error and warnings
    echo -e 'installing plugins...'
    vim -E -s -u "~/.vimrc" +PlugInstall +qall || true
    echo -e " <<< Vim-plugin-manager Installation Finished!"
}

install_neovim() {
    echo -e "\n >>> Neovim Installation Started..."
    # Download
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    # Clean
    sudo rm -rf /opt/nvim-linux-x86_64
    # Install
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    # Export
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
    # Create symbolic links
    ln -sf ~/dotfiles/nvim ~/.config/nvim
    ln -sf ~/dotfiles/stylua ~/.config/stylua
    echo -e " <<< Neovim Installation Finished!"
}

install_code_minimap() {
    #
    # Comment:
    #   This function downloads code-minimap binary for x86_64 architecture.
    #   This is for a vim plugin, "wfxr/minimap.vim"
    #
    echo -e "\n >>> Code-Minimap Installation Started..."
    # Set target variables
    target_dir=".vim/plugged/minimap.vim/code-minimap"
    target_ver="v0.6.7"
    target_tar="code-minimap-v0.6.7-x86_64-unknown-linux-gnu.tar.gz"
    target_bin="code-minimap-v0.6.7-x86_64-unknown-linux-gnu/code-minimap"
    # Check if configuration directory exists
    # Create if it does not exist
    echo -e 'checking directory...'
    if [[ ! -e ~/${target_dir} ]] ; then
        mkdir -p ~/${target_dir}
    fi
    # Download
    wget -O ~/${target_dir}/${target_tar} \
        https://github.com/wfxr/code-minimap/releases/download/${target_ver}/${target_tar}
    # Extract
    tar -xvf ~/${target_dir}/${target_tar} -C ~/${target_dir}
    # Create symbolic links
    echo -e 'creating symbolic links...'
    sudo ln -sf ~/${target_dir}/${target_bin} /usr/local/bin/code-minimap
    echo -e " <<< Code-Minimap Installation Finished!"
}

install_coc() {
    echo -e "\n >>> CoC Installation Started..."
    # Check if configuration directory exists
    # Create if it does not exist
    echo -e 'checking directory...'
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
    ln -sf ~/dotfiles/coc/c.snippets ~/.config/coc/ultisnips/c.snippets
    ln -sf ~/dotfiles/coc/proto.vim ~/.vim/syntax/proto.vim
    echo -e " <<< CoC Installation Finished!"
}

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

#################
# Function Call #
#################
# sudo apt update && sudo apt upgrade -y
# install_ubuntu_general
# install_oh_my_zsh
# install_oh_my_tmux
# install_nerd_fonts
# install_gogh_color_scheme
# install_ranger
# install_fzf
# install_nvm
# install_anaconda
# install_pyenv
# install_vim_plugin_manager
# install_code_minimap
# install_coc
# install_cpp
# sudo apt autoremove -y
