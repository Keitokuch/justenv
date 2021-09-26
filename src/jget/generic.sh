# Generic for linux and macos

_get_prereq() {
    jget_install -s autoconf automake
}

_get_autoconf() {
    local version=${VERSION:-$AUTOCONF_VERSION}
    wget http://ftp.gnu.org/gnu/autoconf/autoconf-$version.tar.gz
    tar -xzf autoconf-$version.tar.gz
    cd autoconf-$version
    ./configure --prefix=$prefix
    make
    make install
}
_rm_autoconf() {
    local version=${VERSION:-$AUTOCONF_VERSION}
    wget http://ftp.gnu.org/gnu/autoconf/autoconf-$version.tar.gz
    tar -xzf autoconf-$version.tar.gz
    cd autoconf-$version
    ./configure --prefix=$prefix
    make uninstall
}

_get_automake() {
    local version=${VERSION:-$AUTOMAKE_VERSION}
    wget https://ftp.gnu.org/gnu/automake/automake-$version.tar.gz
    tar -xzf automake-$version.tar.gz
    cd automake-$version
    ./configure --prefix=$prefix
    make && make install
}
_rm_automake() {
    local version=${VERSION:-$AUTOMAKE_VERSION}
    wget https://ftp.gnu.org/gnu/automake/automake-$version.tar.gz
    tar -xzf automake-$version.tar.gz
    cd automake-$version
    ./configure --prefix=$prefix
    make uninstall
} 

_get_zsh() {
    local version=${VERSION:-$ZSH_VERSION}
    get_ncurses
    wget https://github.com/zsh-users/zsh/archive/zsh-$version.tar.gz
    tar -xzf zsh-$version.tar.gz
    rm zsh-$version.tar.gz
    cd zsh-*
    ./Util/preconfig
    CPPFLAGS="-I$JGET/include -I$JGET/include/ncurses" LDFLAGS="-L$JGET/lib" ./configure --prefix=$prefix
    make -j $nr_worker
    make install.bin
    make install.modules
    make install.fns
}


_get_node() {
    local version=${VERSION:-$NODEJS_VERSION}
    local distro=$ostype-x64
    lib_nodejs=$JGET/lib/nodejs
    nodejs=node-$version-$distro
    mkdir -p $lib_nodejs
    wget https://nodejs.org/dist/$version/$nodejs.tar.xz    || return 1
    tar -xJvf $nodejs.tar.xz -C $lib_nodejs                 || return 1 
    JGET_PATH+=("$lib_nodejs/$nodejs/bin")
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
    mv $dir $JGET
    JGET_PATH+=("$JGET/$dir/bin")
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
}

_get_ctags() {
    local build=$BUILD/ctags
    mkdir -p $build 
    git clone https://github.com/universal-ctags/ctags.git $build   || return 1
    cd $build
    ./autogen.sh                        || return 1
    ./configure --prefix=$prefix          || return 1
    make                                || return 1
    make install                        || return 1
}


_get_nvim() {
    local version=${VERSION:-$NVIM_VERSION}
    cd $BIN
    wget -O nvim.appimage https://github.com/neovim/neovim/releases/download/$version/nvim.appimage || return 1
    chmod +x nvim.appimage
    ln -sf nvim.appimage $BIN/nvim
    python -m pip install neovim --user
    python3 -m pip install neovim --user
}


_get_vim() {
    local version=${VERSION:-$VIM_VERSION}
    cd $BUILD
    wget https://github.com/vim/vim/archive/v$version.tar.gz -O vim-$version.tar.gz
    tar xzf vim-$version.tar.gz
    cd vim-$version
    ./configure --prefix=$prefix
    make -j $nr_worker
    make install
}


_get_ag() {
    local version=${VERSION:-$AG_VERSION}
    cd $BUILD
    ag=the_silver_searcher-$version
    wget https://geoff.greer.fm/ag/releases/$ag.tar.gz || return 1
    tar -xvf $ag.tar.gz
    rm $ag.tar.gz
    cd $ag
    ./configure --prefix=$prefix  || return 1
    make -j $nr_worker           || return 1
    make install        || return 1
}
_rm_ag() {
    cd $BIN && rm -f ag
}


_get_tmux() {
    local version=${VERSION:-$TMUX_VERSION}
    get_libevent
    get_ncurses
    cd $BUILD
    wget https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz || return 1
    tar -xzf tmux-$version.tar.gz
    cd tmux-$version
    CPPFLAGS="-I$JGET/include -I$JGET/include/ncurses" LDFLAGS="-L$JGET/lib" ./configure --prefix=$prefix
    make -j $nr_worker
    make install
}
_rm_tmux() {
    cd $BIN && rm -f tmux
}


_get_autojump() {
    jenv_get python -s
    cd $BUILD
    git clone git://github.com/wting/autojump.git
    cd autojump
    ./install.py
}
_rm_autojump() {
    cd $BUILD
    git clone git://github.com/wting/autojump.git
    cd autojump
    ./uninstall.py      || return 1
}


_get_gradle() {
    local version=${VERSION:-$GRADLE_VERSION}
    cd $BUILD
    zipfile=gradle-$version-bin.zip
    unzipped=gradle-$version
    target_dir=$BIN/gradle
    target=$target_dir/$unzipped
    wget https://services.gradle.org/distributions/$zipfile || return 1
    unzip $zipfile
    [[ -d $target_dir ]] && mv $target_dir $BUILD/gradle-bak
    mkdir -p $BIN/gradle
    mv $unzipped $target
    JGET_PATH+=("$target/bin")
    cd $JGET
}
_rm_gradle() {
    cd $BIN && rm -rf gradle
    cd $JGET
}

_get_v2ray() {
    local version=${VERSION} # TODO: v2ray version
    local version_cmd
    local forced_cmd
    [[ $version ]] && version_cmd="--version v${version}"
    [[ $_forced ]] && forced_cmd="--force"
    cd $BUILD
    wget https://install.direct/go.sh   || return 1
    bash ./go.sh $version_cmd $forced_cmd
    ln -sf /usr/bin/v2ray $BIN/
    JGET_PATH+=("$BIN/v2ray")
    cd $JGET
}

_get_gdb() {
    local version=${VERSION:-$GDB_VERSION}
    cd $BUILD
    wget http://ftp.gnu.org/gnu/gdb/gdb-$version.tar.xz || return 1
    tar xvf gdb-$version.tar.xz
    cd gdb-$version
    mkdir build && cd build
    ../configure --prefix=$prefix  || return 1
    make -j $nr_worker          || return 1
    make install                || return 1
    cd $JGET
}

_get_go() {
    local version=${VERSION:-$GO_VERSION}
    cd $BUILD
    wget https://dl.google.com/go/go$version.$ostype-amd64.tar.gz
    tar -C $JGET -xzf go$version.$ostype-amd64.tar.gz
    JGET_PATH+=("$JGET/go/bin")
    cd $JGET
}

get_gef() {
    cd
    wget -q -O "$HOME/.gef.py" https://github.com/hugsy/gef-legacy/raw/master/gef.py
    echo "source $HOME/.gef.py" > "$HOME/.gdbinit"
}

get_libevent() {
    LIBEVENT_VERSION=2.1.12-stable
    if has_lib libevent ; then
        return 0
    fi
    cd $BUILD
    wget https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION/libevent-$LIBEVENT_VERSION.tar.gz
    tar -xzf libevent-$LIBEVENT_VERSION.tar.gz
    cd libevent-$LIBEVENT_VERSION
    CPPFLAGS='-fPIC' ./configure --prefix=$prefix
    make -j$nr_worker
    make install
    cd $JGET
}

get_ncurses() {
    NCURSES_VERSION=6.2
    if has_lib libncurses ; then
        return 0
    fi
    cd $BUILD
    wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz
    tar -xzf ncurses-$NCURSES_VERSION.tar.gz
    cd ncurses-$NCURSES_VERSION
    CXXFLAGS='-fPIC' CFLAGS='-fPIC' CPPFLAGS="-fPIC" ./configure  --prefix=$prefix --with-shared
    make -j $nr_worker
    make install
    cd $JGET
}


# get oh-my-zsh
get_OMZ() {
    parse_options $@
    OMZ=$HOME/.oh-my-zsh
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
    TMP=$HOME/.tmux/plugins
    if [[ ! -d "$TMP/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm.git $TMP/tpm
    fi
}

_get_ant() {
    local version=${VERSION:-$ANT_VERSION}
    # wget https://downloads.apache.org//ant/binaries/apache-ant-$version-bin.tar.gz
    wget https://archive.apache.org/dist/ant/binaries/apache-ant-$version-bin.tar.gz
    tar -xzf apache-ant-*
    mv apache-ant-$version $BIN/
    add_path "$BIN/apache-ant-$version/bin"
}
_rm_ant() {
    cd $BIN
    rm -rf apache-ant-*
    remove_path "$BIN/apache-ant-*"
}
