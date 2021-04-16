# macos
# $ostype is set to  "darwin"
# $OS is set to "macos"

get_update() {
    brew update
}

_get_sys_prereq() {
    jget_install -s brew
}

get_build() {
    xcode-select --install
    return 0
}

_get_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

_get_ctags() {
    brew install --HEAD universal-ctags/universal-ctags/universal-ctags
}

_get_nvim() {
    local version=${VERSION:-$NVIM_VERSION}
    cd $BUILD
    wget https://github.com/neovim/neovim/releases/download/$version/nvim-macos.tar.gz || return 1
    tar xzvf nvim-macos.tar.gz
    mv $BIN/nvim-osx64 $BUILD/nvim-bak 2>/dev/null
    mv nvim-osx64 $BIN/
    JGET_PATH+=("$BIN/nvim-osx64/bin")
    rm nvim-macos.tar.gz
}

_get_vim() {
    brew install vim
    brew link vim
}

_get_zsh() {
    brew install zsh zsh-completions
}


_get_curl() {
    brew install curl
}

_get_wget() {
    brew install wget
}

get_libevent() {
    brew list libevent > /dev/null || brew install libevent
}

get_ncurses() {
    brew list ncurses > /dev/null || brew install ncurses
}

get_nodejs() {
    if ! [[ -x $(command -v node) ]]; then
        brew install node
        MSG+=(">>> installed nodejs <<<")
    else 
        MSG+=("=== nodejs already installed ===")
    fi 
}

get_ag() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v ag) ]]; then
        brew install the_silver_searcher
        [[ $silent ]] || MSG+=(">>> installed ag <<<")
    else
        [[ $silent ]] || MSG+=("=== ag already installed ===")
    fi 
}
