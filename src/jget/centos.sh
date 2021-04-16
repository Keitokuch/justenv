#! /usr/bin/env bash 

# CentOS

get_ag() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v ag) ]]; then
        yum install the_silver_searcher
        [[ $silent ]] || MSG+=(">>> installed ag <<<")
    else
        [[ $silent ]] || MSG+=("=== ag already installed ===")
    fi 
}

get_python3() {
    VERSION=$PY_VERSION
    parse_options $@

    if [[ $forced ]] || [[ ! -x $(command -v python3) ]]; then
        sudo yum install yum-utils
        sudo yum-builddep python3
        sudo yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel gcc libffi-devel gcc make automake autoconf libtool libffi-devel
        curl -O https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tar.xz
        tar xf Python-${VERSION}.tar.xz
        cd Python-${VERSION}
        ./configure && make
        sudo make install
        sudo rm -rf Python-${VERSION}
        rm Python-${VERSION}.tar.xz
        [[ $silent ]] || MSG+=(">>> installed python3 <<<")
    else
        [[ $silent ]] || MSG+=('=== python3 already installed ===')
    fi
}


get_tmux() {
    VERSION=$TMUX_VERSION
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v tmux) ]] ; then
        sudo yum install libevent-devel
        sudo yum install ncurses-devel
        wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
        tar -xvf tmux-${VERSION}.tar.gz
        cd tmux-${VERSION}
        ./configure && make
        sudo make install
        rm tmux-${VERSION}.tar.gz
        [[ $silent ]] || MSG+=(">>> installed tmux <<<")
    else
        [[ $silent ]] || MSG+=("=== tmux already installed ===")
    fi 
    # get tpm
    if [[ ! -d "$TMP/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
    fi
}


get_nvim() {
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v nvim) ]]; then
        sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        get_python3 -s
        sudo yum install -y neovim python3-neovim
        pip3 install neovim
        [[ $silent ]] || MSG+=(">>> installed neovim <<<")
    else 
        [[ $silent ]] || MSG+=("=== neovim already installed ===")
    fi
}


get_nodejs() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v node) ]]; then
        yum install -y gcc-c++ make
        curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
        [[ $silent ]] || MSG+=(">>> installed nodejs <<<")
    else 
        [[ $silent ]] || MSG+=("=== nodejs already installed ===")
    fi 
}


get_zsh() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v zsh) ]]; then
        sudo yum install zsh
        if [[ -x "/bin/zsh" ]]; then
            chsh -s "/bin/zsh"
        else 
            chsh -s $(which zsh) 
        fi
        [[ $silent ]] || MSG+=(">>> installed zsh <<<")
    else
        [[ $silent ]] || MSG+=("=== zsh already installed ===")
    fi 
}


get_curl() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v curl) ]]; then
        sudo yum install curl 
        [[ $silent ]] || MSG+=(">>> installed curl <<<")
    else
        [[ $silent ]] || MSG+=("=== curl already installed ===")
    fi 
}
