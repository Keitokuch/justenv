#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MODULE=$ENV/modules
UTILS=$ENV/utils
SCRIPT=$ENV/scripts
declare -a MSG=()
declare -a CLEANUP=("put_msg")

. $ENV/justenv.config
. $ENV/src/env_utils.sh
. $ENV/src/justenv_core.sh

JUSTENV=$HOME/.justenv
CONFIG_PATH=${CONFIG_PATH:-"$ENV/configs"}
OLD=$JUSTENV/oldconfigs
mkdir -p $JUSTENV
mkdir -p $CONFIG_PATH
mkdir -p $OLD
SYS_RC=$HOME/.bashrc

THEME=$CONFIG_PATH/themes
DOTFILE=$CONFIG_PATH

usage() {
    echo "Usage: $0 install | deploy [config_item] | uninstall"
}

do_install() {
    modules_install
    do_deploy
}

do_deploy() {
    if [[ $# -gt 0 ]]; then
        if has_func deploy_$1 ; then
            deploy_$1 
            echo "Justenv deploy_$1"
        else 
            echo "No deployable config for $1"
        fi
    else
        MSG+=(">>> Justenv deploy all")
        cd $CONFIG_PATH
        deploy_configs
        [[ -f $CONFIG_PATH/after_deploy ]] && . $CONFIG_PATH/after_deploy && MSG+=(">>> exec after_deploy")
        cd $ENV
    fi
}

main() {
    opt=$1
    shift
    case $opt in
        install)
            do_install
            clean_up
            [[ "$zsh" =~  ^(y|r)$ ]] && zsh
            ;;
        deploy)
            do_deploy $@
            clean_up
            ;;
        uninstall)
            echo "Not implemented"
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
