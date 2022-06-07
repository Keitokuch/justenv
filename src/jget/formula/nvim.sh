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
    python3 -m pip install neovim --user
}

remove() {
    cd $BIN
    rm -r nvim*
}

exists() {
    has_command nvim
}

get_linux() {
    wget -O nvim.appimage https://github.com/neovim/neovim/releases/download/$version/nvim.appimage || return
    chmod +x nvim.appimage
    mv nvim.appimage $BIN/nvim.appimage
    ln -sf $BIN/nvim.appimage $BIN/nvim
}

get_macos() {
    wget https://github.com/neovim/neovim/releases/download/$version/nvim-macos.tar.gz || return
    tar xzf nvim-macos.tar.gz
    mv $BIN/nvim-osx64 $BUILD/nvim-bak 2>/dev/null
    mv nvim-osx64 $BIN/
    add_path "$BIN/nvim-osx64/bin"
}
