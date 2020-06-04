#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MODULE=$ENV/modules
UTILS=$ENV/utils
SCRIPT=$ENV/scripts

. $ENV/justenv.config
. $UTILS/env_utils.sh

JUSTENV=$HOME/.justenv
CONFIG=${CONFIG_PATH:-"$ENV/configs"}
mkdir -p $JUSTENV
mkdir -p $CONFIG
SYS_RC=$HOME/.bashrc


JGET=$ENV/jenv-get
. $JGET/jenv_core.sh

jenv_init

pull_configs
THEME=$CONFIG/themes
DOTFILE=$CONFIG/dotfiles

. $MODULE/modules_install.sh
deploy_terminfo

jenv_after

[[ "$zsh" =~  ^(y|r)$ ]] && zsh
