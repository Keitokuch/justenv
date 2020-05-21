#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
MODULE=$ENV/modules
UTILS=$ENV/utils
SCRIPT=$ENV/scripts

. justenv.config
THEME=$ENV/$SRC/themes
DOTFILE=$ENV/$SRC/dotfiles


JUSTENV=~/.justenv
BUILD=$ENV/build
CONFIG=$ENV/configs
BIN=$ENV/bin
mkdir -p $JUSTENV
mkdir -p $BUILD
mkdir -p $CONFIG
mkdir -p $BIN

. $UTILS/env_utils.sh
. $SETUP/setup.sh

jenv_get test
put_msg
