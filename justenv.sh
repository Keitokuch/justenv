#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MODULE=$ENV/modules
UTILS=$ENV/utils
SCRIPT=$ENV/scripts

. $ENV/justenv.config
. $ENV/src/env_utils.sh
. $ENV/src/justenv_core.sh

JUSTENV=$HOME/.justenv
CONFIG=${CONFIG_PATH:-"$ENV/configs"}
mkdir -p $JUSTENV
mkdir -p $CONFIG
SYS_RC=$HOME/.bashrc

THEME=$CONFIG/themes
DOTFILE=$CONFIG/dotfiles

usage() {
    echo "Usage: $0 install | deploy [config_item] | uninstall"
}

do_install() {
    JGET=$ENV/jenv-get
    . $JGET/jenv_core.sh
    pull_configs
    jenv_init
    . $MODULE/modules_install.sh
    deploy_terminfo
    jenv_after
}

do_deploy() {
    pull_configs
    if [[ $# -gt 0 ]]; then
        if has_func deploy_$1 ; then
            deploy_$1 
            echo "Justenv deploy_$1"
        else 
            echo "No deployable config for $1"
        fi
    else
        echo "Justenv deploy all"
        deploy_configs
    fi
}

main() {
    opt=$1
    shift
    case $opt in
        install)
            do_install
            [[ "$zsh" =~  ^(y|r)$ ]] && zsh
            ;;
        deploy)
            do_deploy $@
            put_msg
            ;;
        func)
            $@
            ;;
        *)
            usage
            exit 0
            ;;
    esac
}

main $@
