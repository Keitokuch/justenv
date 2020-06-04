#! /usr/bin/env bash 

OMZ=$HOME/.oh-my-zsh
TMP=$HOME/.tmux/plugins
pull_configs() {
    cp -rf $SRC/* $CONFIG
}

has_func() {
    declare -f $_func > /dev/null
    return $?
}

put_file() {
    mkdir -p $(dirname "$2") && cp "$1" "$2"
}

check_append() {
    grep -qxsF -- "$1" "$2" || echo "$1" >> "$2"
}

# display messages
put_msg() {
    for msg in "${MSG[@]}"; do
        echo $msg
    done
}
