#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MODULE=$ENV/modules
UTILS=$ENV/utils
SCRIPT=$ENV/scripts

. $ENV/justenv.config
. $UTILS/env_utils.sh

THEME=$ENV/$SRC/themes
DOTFILE=$ENV/$SRC/dotfiles

JUSTENV=$HOME/.justenv
CONFIG=$ENV/configs
mkdir -p $JUSTENV
mkdir -p $CONFIG
SYS_RC=$HOME/.bashrc


JGET=$ENV/jenv-get
. $JGET/core.sh

jenv_init

pull_configs

. $MODULE/modules_install.sh

jenv_after

[[ "$zsh" =~  ^(y|r)$ ]] && zsh
