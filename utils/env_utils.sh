#! /usr/bin/env bash 

pull_configs() {
    cp -f $DOTFILE/init.vim $CONFIG/init.vim
    cp -f $DOTFILE/tmux.conf $CONFIG/tmux.conf
    cp -f $DOTFILE/tmux.remote.conf $CONFIG/tmux.remote.conf
    cp -f $DOTFILE/zshrc $CONFIG/zshrc
    cp -f $DOTFILE/zshrc.ubuntu $CONFIG/zshrc.ubuntu
}

has_func() {
    declare -f $_func > /dev/null
    return $?
}

put_file() {
    mkdir -p $(dirname "$2") && cp "$1" "$2"
}
