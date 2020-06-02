# ubuntu

get_update() {
    sudo apt update
}

get_prereq() {
    sudo apt install -y curl
    sudo apt install -y wget
}

get_curl() {
    sudo apt-get install -y curl
}

get_build() {
    sudo apt install -y build-essential
}

get_tmux() {
    VERSION=$TMUX_VERSION
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v tmux) ]] ; then
        sudo apt install -y libevent-dev libncurses-dev
        cd $BUILD
        wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
        tar -xvf tmux-${VERSION}.tar.gz
        cd tmux-${VERSION}
        ./configure && make
        sudo make install
        cd $BUILD && rm tmux-${VERSION}.tar.gz
        cd $ENV 
        [[ $silent ]] || MSG+=(">>> installed tmux <<<")
    else
        [[ $silent ]] || MSG+=("=== tmux already installed ===")
    fi 
    # get tpm
    if [[ ! -d "$TMP/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
    fi
}

_get_zsh() {
    sudo apt install -y zsh
    if [[ -x "/bin/zsh" ]]; then
        chsh -s "/bin/zsh"
    else 
        chsh -s $(which zsh) 
    fi
}

_get_nvim() {
    version=${VERSION:-$NVIM_VERSION}
    cd $BIN
    wget https://github.com/neovim/neovim/releases/download/${VERSION}/nvim.appimage || return 1
    chmod +x nvim.appimage
    sudo ln -f nvim.appimage /usr/local/bin/nvim
    cd $ENV
    sudo apt install -y python-neovim || return 1
    sudo apt install -y python3-neovim || return 1
}

get_nvim() {
    VERSION=$NVIM_VERSION
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v nvim) ]]; then
        cd $BIN
        wget https://github.com/neovim/neovim/releases/download/${VERSION}/nvim.appimage
        chmod +x nvim.appimage
        sudo ln -f nvim.appimage /usr/local/bin/nvim
        cd $ENV
        sudo apt install -y python-neovim
        sudo apt install -y python3-neovim
        [[ $silent ]] || MSG+=(">>> installed neovim <<<")
    else 
        [[ $silent ]] || MSG+=("=== neovim already installed ===")
    fi
}

_get_node() {
    curl -sL install-node.now.sh/lts | sudo bash
}

get_nodejs() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v node) ]]; then
        curl -sL install-node.now.sh/lts | sudo bash
        [[ $silent ]] || MSG+=(">>> installed nodejs <<<")
    else 
        [[ $silent ]] || MSG+=("=== nodejs already installed ===")
    fi 
}

get_python3() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v python3) ]]; then
        sudo apt install -y python3
        sudo apt install -y python3-pip
        [[ $silent ]] || MSG+=(">>> installed python3 <<<")
    else
        [[ $silent ]] || MSG+=('=== python3 already installed ===')
    fi
}

get_kbuild() {
    sudo apt install build-essential kernel-package libncurses5-dev
    apt install -y flex bison
    apt install -y openssl libssl-dev libelf-dev
    MSG+=(">>> installed kernel build dependencies.")
}

get_ranger() {
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v ranger) ]]; then
        sudo apt install -y ranger
        [[ $silent ]] || MSG+=(">>> installed ranger <<<")
    else
        [[ $silent ]] || MSG+=('=== ranger already installed ===')
    fi
}

get_ctags() {
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v ctags) ]]; then
        build=$BUILD/ctags
        mkdir -p $build
        sudo apt install -y \
            gcc make pkg-config autoconf automake \
            python3-docutils libseccomp-dev libjansson-dev \
            libyaml-dev libxml2-dev
        git clone https://github.com/universal-ctags/ctags.git $build
        cd $build
        ./autogen.sh
        ./configure && make
        sudo make install
        cd $ENV
        [[ $silent ]] || MSG+=(">>> installed ctags <<<")
    else
        [[ $silent ]] || MSG+=('=== ctags already installed ===')
    fi
}

_get_ag() {
    sudo apt-get install -y silversearcher-ag
}
