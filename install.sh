#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
MODULE=$ENV/modules
UTILS=$ENV/utils
SCRIPT=$ENV/scripts
JGET=$ENV/jenv-get

. $ENV/justenv.config
THEME=$ENV/$SRC/themes
DOTFILE=$ENV/$SRC/dotfiles

JUSTENV=$HOME/.justenv
CONFIG=$ENV/configs
mkdir -p $JUSTENV
mkdir -p $CONFIG

. $UTILS/env_utils.sh
. $SETUP/setup.sh
. $JGET/jenv_core.sh

SYS_RC=$HOME/.bashrc

jenv_init

pull_configs

nr_worker=$(nproc)
. $MODULE/modules_install.sh

jenv_setup
put_msg
# rm -rf $BUILD

[[ "$zsh" =~  ^(y|r)$ ]] && zsh
