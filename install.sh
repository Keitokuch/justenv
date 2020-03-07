#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
MODULE=$ENV/modules
UTILS=$ENV/utils

. justenv.config
THEME=$ENV/$SRC/themes
DOTFILE=$ENV/$SRC/dotfiles

JUSTENV=~/.justenv
CONFIG=$ENV/configs
mkdir -p $JUSTENV
mkdir -p $CONFIG

. $UTILS/env_utils.sh
. $SETUP/setup.sh

pull_configs

. $MODULE/modules.sh

if [[ $zsh == "y" ]]; then
    zsh
fi

put_msg

