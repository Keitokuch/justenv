#! /usr/bin/env bash 

OMZ=$HOME/.oh-my-zsh
TMP=$HOME/.tmux/plugins

jenv_get() {
    app=$1
    shift 1
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v $app) ]]; then
        _func=_get_$app
        has_func $_func || { MSG+=("[ ERROR ] $_func not implemented") ; return 1 ;}
        if $_func ; then
            [[ $silent ]] || MSG+=(">>> installed $app <<<")
        else
            MSG+=("[ ERROR ] Failed to install $app")
        fi
    else
       [[ $silent ]] || MSG+=("=== $app already installed ===")
    fi
}

_get_node() {
    version=${VERSION:-$NODEJS_VERSION}
    distro=$OSTYPE-x64
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
    _get_ncurses
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
    make -j $nr_worker           || return 1
    make install        || return 1
    cd $ENV
}

_get_tmux() {
    version=${VERSION:-$TMUX_VERSION}
    _get_libevent
    _get_ncurses
    cd $BUILD
    wget https://github.com/tmux/tmux/releases/download/$version/tmux-$version.tar.gz || return 1
    tar -xzf tmux-$version.tar.gz
    cd tmux-$version
    CPPFLAGS="-I$JENV/include -I$JENV/include/ncurses" LDFLAGS="-L$JENV/lib" ./configure --prefix=$JENV
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
    CPPFLAGS="-fPIC" ./configure --prefix=$JENV
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

get_vimplug() {
    parse_options $@
    if [[ $forced ]] || [[ ! -f  ~/.local/share/nvim/site/autoload/plug.vim ]]; then 
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        [[ $silent ]] || MSG+=(">>> installed vim-plug <<<")
    else
        [[ $silent ]] || MSG+=("=== vim-plug already installed ===")
    fi 
}

get_tpm() {
    if [[ ! -d "$TMP/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm.git $TMP/tpm
    fi
}

deploy_zsh() {
    MSG+=(">>> deploying zsh configs")
    ln -sf $THEME/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
    [[ -f ~/.zshrc ]] && cp ~/.zshrc $JUSTENV/zshrc.old
    ln -sf $CONFIG/zshrc ~/.zshrc
    if [[ -f $CONFIG/zshrc.$OS ]]; then
        ln -sf $CONFIG/zshrc.$OS ~/.zshrc.native
    fi
}

deploy_tmux() {
    MSG+=(">>> deploying tmux configs")
    [[ -f ~/.tmux.conf ]] && cp ~/.tmux.conf $JUSTENV/tmux.conf.old
    ln -sf $CONFIG/tmux.conf ~/.tmux.conf
    mkdir -p ~/.tmux
    ln -sf $CONFIG/tmux.remote.conf ~/.tmux/tmux.remote.conf
    cp -f $SCRIPT/cpu_usage.sh ~/.tmux/cpu_usage.sh
    cp -f $SCRIPT/mem_usage.sh ~/.tmux/mem_usage.sh
}

deploy_nvim() {
    MSG+=(">>> deploying nvim configs")
    mkdir -p ~/.config/nvim/
    [[ -f ~/.config/nvim/init.vim ]] && cp ~/.config/nvim/init.vim $JUSTENV/init.vim.old
    ln -sf $CONFIG/init.vim ~/.config/nvim/init.vim

    # vim colorscheme
    mkdir -p ~/.config/nvim/colors/
    cp $THEME/*.vim ~/.config/nvim/colors/
}

# Not used
deploy_vim() {
    MSG+=(">>> deploying vim configs")
    mkdir -p ~/.config/nvim/
    cp $DOTFILE/vimrc ~/.vimrc

    # vim colorscheme
    mkdir -p ~/.vim/colors/ 
    mkdir -p ~/.config/nvim/colors/
    cp $THEME/vim-keitoku.vim ~/.vim/colors/ 
}

deploy_configs() {
    deploy_zsh
    deploy_tmux
    deploy_nvim
}

deploy_terminfo() {
    cd $SCRIPT/terminfo
    tic -o $HOME/.terminfo tmux.terminfo
    tic -o $HOME/.terminfo tmux-256color.terminfo
    tic -o $HOME/.terminfo xterm-256color.terminfo
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

