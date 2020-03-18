#! /usr/bin/env bash 

declare -a MSG=()

parse_options() {
    #for var in "$@"
    #do
    #    [[ $var == f ]] && forced=1
    #    [[ $var == s ]] && silent=1
    #    [[ $var == v ]] && ver=1
    #    [[ $ver ]] && VERSION=$var
    #done
    unset forced silent
    local OPTIND
    while getopts ":fsv:" opt ; do
        case $opt in
            f)
                forced=1
                ;;
            s)
                silent=1
                ;;
            v)
                VERSION=$OPTARG
                ;; 
        esac 
    done
}

# print log
put_msg() {
    for msg in "${MSG[@]}"; do
        echo $msg
    done
}

pull_configs() {
    cp -f $DOTFILE/init.vim $CONFIG/init.vim
    cp -f $DOTFILE/tmux.conf $CONFIG/tmux.conf
    cp -f $DOTFILE/tmux.remote.conf $CONFIG/tmux.remote.conf
    cp -f $DOTFILE/zshrc $CONFIG/zshrc
    cp -f $DOTFILE/zshrc.ubuntu $CONFIG/zshrc.ubuntu
}
