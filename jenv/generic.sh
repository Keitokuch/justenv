OMZ=$HOME/.oh-my-zsh
TMP=$HOME/.tmux/plugins

_get_node() {
    version=${VERSION:-$NODEJS_VERSION}
    distro=$ostype-x64
    lib_nodejs=$JENV/lib/nodejs
    nodejs=node-$version-$distro
    mkdir -p $lib_nodejs
    cd $BUILD
    wget https://nodejs.org/dist/$version/$nodejs.tar.xz    || return 1
    tar -xJvf $nodejs.tar.xz -C $lib_nodejs                 || return 1 
    rm $nodejs.tar.xz
    JENV_PATH+=("$lib_nodejs/$nodejs/bin")
    cd $ENV
}

_get_ctags() {
    build=$BUILD/ctags
    mkdir -p $build 
    git clone https://github.com/universal-ctags/ctags.git $build   || return 1
    cd $build
    ./autogen.sh                        || return 1
    ./configure --prefix=$JENV          || return 1
    make                                || return 1
    make install                        || return 1
    cd $ENV
}

_get_zsh() {
    get_ncurses
    cd $BUILD
    git clone git://github.com/zsh-users/zsh.git
    cd zsh
    autoheader
    autoconf
    CPPFLAGS="-I$JENV/include -I$JENV/include/ncurses" LDFLAGS="-L$JENV/lib" ./configure --prefix=$JENV --with-tcsetpgrp --without-shared
    make -j $nr_worker
    make install
    cd $ENV
    chsh -s $(chsh -l | grep zsh) $USER 
}

_get_nvim() {
    version=${VERSION:-$NVIM_VERSION}
    cd $BIN
    wget https://github.com/neovim/neovim/releases/download/$version/nvim.appimage || return 1
    chmod +x nvim.appimage
    ln -f nvim.appimage $BIN/nvim
    cd $ENV
    python -m pip install neovim --user
    python3 -m pip install neovim --user
}

_get_vim() {
    version=${VERSION:-$VIM_VERSION}
    cd $BUILD
    wget https://github.com/vim/vim/archive/v$version.tar.gz -O vim-$version.tar.gz
    tar xzf vim-$version.tar.gz
    cd vim-$version
    ./configure --prefix=$JENV
    make -j $nr_worker
    make install
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
    make -j $nr_worker           || return 1
    make install        || return 1
    cd $ENV
}

_get_tmux() {
    version=${VERSION:-$TMUX_VERSION}
    get_libevent
    get_ncurses
    cd $BUILD
    wget https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz || return 1
    tar -xzf tmux-$version.tar.gz
    cd tmux-$version
    CPPFLAGS="-I$JENV/include -I$JENV/include/ncurses" LDFLAGS="-L$JENV/lib" ./configure --prefix=$JENV
    make -j $nr_worker
    make install
    cd $ENV
}

_get_gdb() {
    version=${VERSION:-$GDB_VERSION}
    cd $BUILD
    wget http://ftp.gnu.org/gnu/gdb/gdb-$version.tar.xz || return 1
    tar xvf gdb-$version.tar.xz
    cd gdb-$version
    mkdir build && cd build
    ../configure --prefix=$JENV  || return 1
    make -j $nr_worker          || return 1
    make install                || return 1
}

get_gef() {
    cd
    wget -q -O "$HOME/.gef.py" https://github.com/hugsy/gef-legacy/raw/master/gef.py
    echo "source $HOME/.gef.py" > "$HOME/.gdbinit"
}

get_libevent() {
    LIBEVENT_VERSION=2.0.22-stable
    if has_lib libevent ; then
        return 0
    fi
    cd $BUILD
    wget https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION/libevent-$LIBEVENT_VERSION.tar.gz
    tar -xzf libevent-$LIBEVENT_VERSION.tar.gz
    cd libevent-$LIBEVENT_VERSION
    CPPFLAGS="-fPIC" ./configure --prefix=$JENV
    make -j$nr_worker
    make install
    cd $ENV
}

get_ncurses() {
    NCURSES_VERSION=6.0
    if has_lib libncurses ; then
        return 0
    fi
    cd $BUILD
    wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz
    tar -xzf ncurses-$NCURSES_VERSION.tar.gz
    cd ncurses-$NCURSES_VERSION
    CXXFLAGS='-fPIC' CFLAGS='-fPIC' CPPFLAGS="-fPIC" ./configure  --prefix=$JENV --with-shared
    make -j $nr_worker
    make install
    cd $ENV
}


# get oh-my-zsh
get_OMZ() {
    parse_options $@
    if [[ $forced ]] || [[ ! -d $OMZ ]]; then
        sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended" 
       [[ $silent ]] ||  MSG+=(">>> installed oh-my-zsh <<<")
    else
       [[ $silent ]] || MSG+=("=== oh-my-zsh already installed ===")
    fi
}

get_vim-plug() {
    parse_options $@
    if [[ $forced ]] || [[ ! -f  ~/.local/share/nvim/site/autoload/plug.vim ]]; then 
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        [[ $silent ]] || MSG+=(">>> installed vim-plug for neovim <<<")
    else
        [[ $silent ]] || MSG+=("=== vim-plug already installed for neovim ===")
    fi 

    if [[ $forced ]] || [[ ! -f  ~/.vim/autoload/plug.vim ]]; then 
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        [[ $silent ]] || MSG+=(">>> installed vim-plug for vim <<<")
    else
        [[ $silent ]] || MSG+=("=== vim-plug already installed for vim ===")
    fi 
}

get_tpm() {
    if [[ ! -d "$TMP/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm.git $TMP/tpm
    fi
}



get_invalid() {
    MSG+=("$1: setup for $OS not implemented.")
}
get_build() { 
    get_invalid ${FUNCNAME[0]} 
}
get_update()  {
    get_invalid ${FUNCNAME[0]} 
}
get_prereq() {
    get_invalid ${FUNCNAME[0]}
}
get_curl() {
    get_invalid ${FUNCNAME[0]}
}
get_zsh() {
    get_invalid ${FUNCNAME[0]}
}
get_nvim() {
    get_invalid ${FUNCNAME[0]}
}
get_nodejs() {
    get_invalid ${FUNCNAME[0]}
}
get_tmux() {
    get_invalid ${FUNCNAME[0]}
}
get_python3() {
    get_invalid ${FUNCNAME[0]}
}
get_ranger() {
    get_invalid ${FUNCNAME[0]}
}
get_ctags() {
    get_invalid ${FUNCNAME[0]}
}
get_ag() {
    get_invalid ${FUNCNAME[0]}
}

