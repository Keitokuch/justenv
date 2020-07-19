OMZ=$HOME/.oh-my-zsh
TMP=$HOME/.tmux/plugins

_get_node() {
    local version=${VERSION:-$NODEJS_VERSION}
    local distro=$ostype-x64
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

_get_cmake() {
    local version=${VERSION:-$CMAKE_VERSION}
    [[ $ostype == darwin ]] && _ostype=Darwin
    [[ $ostype == linux ]] && _ostype=Linux
    tarball=cmake-$version-$_ostype-x86_64.tar.gz
    dir=cmake-$version-$_ostype-x86_64
    cd $BUILD
    wget https://github.com/Kitware/CMake/releases/download/v$version/$tarball
    tar xvf $tarball
    mv $dir $JENV
    JENV_PATH+=("$JENV/$dir/bin")
    cd $ENV
}

_get_BaiduPCS-Go() {
    local version=${VERSION:-$BAIDUPCS_VERSION} 
    [[ $ostype == darwin ]] && _ostype=darwin-osx
    [[ $ostype == linux ]] && _ostype=linux
    zipfile=BaiduPCS-Go-v$version-$_ostype-amd64.zip
    dir=BaiduPCS-Go-v$version-$_ostype-amd64
    cd $BUILD
    wget https://github.com/felixonmars/BaiduPCS-Go/releases/download/v$version/$zipfile    || return 1
    unzip $zipfile      || return 1
    mv $dir/BaiduPCS-Go $BIN
    cd $ENV
}

_get_ctags() {
    local build=$BUILD/ctags
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
    local version=${VERSION:-$NVIM_VERSION}
    cd $BIN
    wget https://github.com/neovim/neovim/releases/download/$version/nvim.appimage || return 1
    chmod +x nvim.appimage
    ln -f nvim.appimage $BIN/nvim
    cd $ENV
    python -m pip install neovim --user
    python3 -m pip install neovim --user
}

_get_vim() {
    local version=${VERSION:-$VIM_VERSION}
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
    local version=${VERSION:-$AG_VERSION}
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
    local version=${VERSION:-$TMUX_VERSION}
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

_get_autojump() {
    jenv_get python -s
    cd $BUILD
    git clone git://github.com/wting/autojump.git
    cd autojump
    ./install.py
    cd $ENV
}
_rm_autojump() {
    cd $BUILD
    git clone git://github.com/wting/autojump.git
    cd autojump
    ./uninstall.py      || return 1
    cd $ENV
}

_get_v2ray() {
    local version=${VERSION}
    local version_cmd
    local forced_cmd
    [[ $version ]] && version_cmd="--version v${version}"
    [[ $_forced ]] && forced_cmd="--force"
    cd $BUILD
    echo fff$_forced$forced_cmd
    wget https://install.direct/go.sh   || return 1
    bash ./go.sh $version_cmd $forced_cmd
    ln -sf /usr/bin/v2ray $BIN/
    JENV_PATH+=("$BIN/v2ray")
    cd $ENV
}

_get_gdb() {
    local version=${VERSION:-$GDB_VERSION}
    cd $BUILD
    wget http://ftp.gnu.org/gnu/gdb/gdb-$version.tar.xz || return 1
    tar xvf gdb-$version.tar.xz
    cd gdb-$version
    mkdir build && cd build
    ../configure --prefix=$JENV  || return 1
    make -j $nr_worker          || return 1
    make install                || return 1
    cd $ENV
}

_get_go() {
    local version=${VERSION:-$GO_VERSION}
    cd $BUILD
    wget https://dl.google.com/go/go$version.$ostype-amd64.tar.gz
    tar -C $JENV -xzf go$version.$ostype-amd64.tar.gz
    JENV_PATH+=("$JENV/go/bin")
    cd $ENV
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

