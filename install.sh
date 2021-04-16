#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC=$DIR/src

JGET=~/.jget
BIN=$JGET/bin
CONFIG=~/.config/justenv

mkdir -p $CONFIG
mkdir -p $BIN

cp $SRC/config $CONFIG

check_append() {
    grep -qxsF -- "$1" "$2" || echo "$1" >> "$2"
}

$SRC/justenv install_justenv
