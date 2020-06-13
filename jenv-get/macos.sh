# macos

get_update() {
    brew update
}

get_prereq() {
    jenv_get brew -s
    jenv_get curl -s
    jenv_get wget -s
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
    version=${VERSION:-$NVIM_VERSION}
    cd $BIN
    wget https://github.com/neovim/neovim/releases/download/$version/nvim-macos.tar.gz || return 1
    tar xzvf nvim-macos.tar.gz
    JENV_PATH+=("$BIN/nvim-osx64/bin")
    rm nvim-macos.tar.gz
    cd $ENV
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
