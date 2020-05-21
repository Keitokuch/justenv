#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
MODULE=$ENV/modules
UTILS=$ENV/utils
SCRIPT=$ENV/scripts

. $ENV/justenv.config
THEME=$ENV/$SRC/themes
DOTFILE=$ENV/$SRC/dotfiles


JUSTENV=$HOME/.justenv
BUILD=$ENV/build
CONFIG=$ENV/configs
JENV=$HOME/jenv
BIN=$JENV/bin

mkdir -p $JUSTENV
mkdir -p $BUILD
mkdir -p $CONFIG
mkdir -p $BIN

. $UTILS/env_utils.sh
. $SETUP/setup.sh

SYS_RC=$HOME/.bashrc
JENV_RC=$HOME/.jenv_profile

touch $JENV_RC
check_append "source $JENV_RC" $SYS_RC

pull_configs

. $MODULE/modules.sh

jenv_setup
put_msg

[[ $zsh == "y" ]] && zsh
