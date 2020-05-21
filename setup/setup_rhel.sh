#! /usr/bin/env bash 

# rhel

_get_zsh() {
    cd $BUILD
    wget -O zsh.tar.gz https://sourceforge.net/projects/zsh/files/latest/download || return 1
    mkdir zsh && tar -xvf zsh.tar.gz -C zsh --strip-components 1
    rm zsh.tar.gz
    cd zsh
    ./configure --prefix=$JENV
    make -j nr_worker   || return 1
    make install        || return 1
    cd $ENV
}

_get_nvim() {
    version=${VERSION:-$NVIM_VERSION}
    cd $BIN
    wget https://github.com/neovim/neovim/releases/download/$version/nvim.appimage || return 1
    chmod +x nvim.appimage
    ln -f nvim.appimage $BIN/nvim
    cd $ENV
    pip install neovim --user
    pip3 install neovim --user
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
    make -j nr_worker           || return 1
    make install        || return 1
    cd $ENV
}

_get_tmux() {
    version=${VERSION:-$TMUX_VERSION}
    _get_libevent && _get_ncurses || return 1
    cd $BUILD
    wget https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz || return 1
    tar -xzf tmux-$version.tar.gz
    cd tmux-$version
    CFLAGS="-I$JENV/include" LDFLAGS="-L$JENV/lib" ./configure --prefix=$JENV
    make -j $nr_worker
    make install
    cd $ENV
}

_get_libevent() {
    LIBEVENT_VERSION=2.0.22-stable
    if has_lib libevent ; then
        return 0
    fi
    cd $BUILD
    wget https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION/libevent-$LIBEVENT_VERSION.tar.gz
    tar -xzf libevent-$LIBEVENT_VERSION.tar.gz
    cd libevent-$LIBEVENT_VERSION
    ./configure --prefix=$JENV
    make -j$nr_worker
    make install
    cd $ENV
}

_get_ncurses() {
    NCURSES_VERSION=6.0
    if has_lib libncurses ; then
        return 0
    fi
    cd $BUILD
    wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz
    tar -xzf ncurses-$NCURSES_VERSION.tar.gz
    cd ncurses-$NCURSES_VERSION
    ./configure CPPFLAGS="-P" --prefix=$JENV
    make -j $nr_worker
    make install
    cd $ENV
}
