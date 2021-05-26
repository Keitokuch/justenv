NVIM_VERSION=nightly

get() {
    version=${version:-$NVIM_VERSION}
    case $ostype in
        linux)
            get_linux
            return
            ;;
        darwin)
            get_macos
            return
            ;;
        *)
            ;;
    esac
}

exists() {
    [[ -x $(command -v nvim) ]]
}

get_linux() {
    cd $BIN
    wget -O nvim.appimage https://github.com/neovim/neovim/releases/download/$version/nvim.appimage || return
    chmod +x nvim.appimage
    ln -sf nvim.appimage $BIN/nvim
    python -m pip install neovim --user
    python3 -m pip install neovim --user
}

get_macos() {
    cd $BUILD
    wget https://github.com/neovim/neovim/releases/download/$version/nvim-macos.tar.gz || return
    tar xzf nvim-macos.tar.gz
    mv $BIN/nvim-osx64 $BUILD/nvim-bak 2>/dev/null
    mv nvim-osx64 $BIN/
    JGET_PATH+=("$BIN/nvim-osx64/bin")
    rm nvim-macos.tar.gz
}
