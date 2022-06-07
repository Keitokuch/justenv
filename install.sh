#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC=$DIR/src

CONFIG=~/.config/justenv

mkdir -p $CONFIG

cp $SRC/config $CONFIG

$SRC/justenv install_justenv
