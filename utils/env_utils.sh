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
    unset silent forced VERSION
    while getopts ":fsv:" opt; do
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
    cp $DOTFILE/init.vim $CONFIG/init.vim
    cp $DOTFILE/tmux.conf $CONFIG/tmux.conf
    cp $DOTFILE/tmux.remote.conf $CONFIG/tmux.remote.conf
    cp $DOTFILE/zshrc $CONFIG/zshrc
}
