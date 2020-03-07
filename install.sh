#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
MODULE=$ENV/modules
CONFIG=$ENV/configs
UTILS=$ENV/utils

. justenv.config
THEME=$ENV/$SRC/themes
DOTFILE=$ENV/$SRC/dotfiles

JUSTENV=~/.justenv/
mkdir $JUSTENV
pull_configs

. $UTILS/env_utils.sh
. $SETUP/setup.sh
. $MODULE/modules.sh


# PY_VERSION=3.6.8
# TMUX_VERSION=3.0a

# get_zsh
# get_tmux   -f
# get_nvim
# get_vimplug
# get_nodejs
# get_OMZ
# get_ctags
# get_ag

# deploy_configs

# put_msg
# zsh
