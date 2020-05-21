#! /usr/bin/env bash 

# rhel

_get_zsh() {
    cd $BUILD
    wget -O zsh.tar.gz https://sourceforge.net/projects/zsh/files/latest/download || return 1
    mkdir zsh && tar -xvf zsh.tar.gz -C zsh --strip-components 1
    rm zsh.tar.gz
    cd zsh
    ./configure --prefix=$JENV
    make || return 1
    make install || return 1
    cd $ENV
}

_get_nvim() {
    version=${VERSION:-$NVIM_VERSION}
    cd $BIN
    wget https://github.com/neovim/neovim/releases/download/${VERSION}/nvim.appimage || return 1
    chmod +x nvim.appimage
    ln -f nvim.appimage $BIN/nvim
    cd $ENV
}

_get_ag() {
    version=${VERSION:-$AG_VERSION}
    cd $BUILD
    ag=the_silver_searcher-$version
    wget https://geoff.greer.fm/ag/releases/$ag.tar.gz || return 1
    tar -xvf $ag.tar.gz
    rm $ag.tar.gz
    cd $ag
    ./configure --prefix=$JENV  || return 1
    make                || return 1
    make install        || return 1
    cd $ENV
}
