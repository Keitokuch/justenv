#! /usr/bin/env bash

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MODULE=$ENV/modules
UTILS=$ENV/utils
SCRIPT=$ENV/scripts
declare -ga MSG=()
declare -ga CLEANUP=("put_msg")

. $ENV/justenv.config

JUSTENV=$HOME/.justenv
CONFIG_PATH=${CONFIG_PATH:-"$ENV/configs"}
OLD=$JUSTENV/oldconfigs
mkdir -p $JUSTENV
mkdir -p $CONFIG_PATH
mkdir -p $OLD

THEME=$CONFIG_PATH/themes
DOTFILE=$CONFIG_PATH

OMZ=$HOME/.oh-my-zsh
TMP=$HOME/.tmux/plugins

usage() {
    echo "Usage: $0 install | deploy [config_item] | uninstall"
}

pull_configs() {
    cp -rf $SRC/* $CONFIG
}

has_func() {
    declare -f $_func > /dev/null
    return $?
}

put_file() {
    mkdir -p $(dirname "$2") && cp "$1" "$2"
}

check_append() {
    grep -qxsF -- "$1" "$2" || echo "$1" >> "$2"
}

# display messages
put_msg() {
    for msg in "${MSG[@]}"; do
        echo $msg
    done
}

clean_up() {
    for tsk in "${CLEANUP[@]}"; do
        $tsk
    done
}

parse_ostype() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        ostype=linux
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
            OSVER=$VERSION_ID
        else
            MSG+=("Failed: linux distro not recognized.")
            return 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS=macos
        ostype=darwin
    else
        MSG+=("Failed: OS type $OSTYPE not supported.")
        return 1
    fi
}

modules_install() {
    jenv_install -s prereq update build

    [[ $zsh == "y" ]] &&  jenv_install zsh OMZ
    [[ $zsh == "r" ]] && jenv_install -f zsh OMZ

    [[ $nvim == "y" ]] &&  jenv_install nvim vim-plug node ctags ag
    [[ $nvim == "r" ]] && jenv_install -f nvim vim-plug node ctags ag

    [[ $tmux == "y" ]] &&  jenv_install tmux -f tpm
    [[ $tmux == "r" ]] && jenv_install -f tmux tpm
}

deploy_configs() {
    while read src dst
    do
        dst=${dst/#~/$HOME}
        src=${src/\$OS/$OS}
        dst=${dst/\$OS/$OS}
        dstdir=`dirname "$dst"`
        dstname=`basename "$dst"`
        [[ -f $dst ]] && cp $dst "$OLD/$dstname.old"
        [[ $dst == */ ]] && mkdir -p $dst || mkdir -p $dstdir
        ln -sf $CONFIG_PATH/${src} ${dst}
        echo "softlink ${src} to ${dst}"
    done <"$CONFIG_PATH/deploy_path"
}

do_install() {
    JGET=$ENV/jenv
    . $JGET/jenv_core.sh

    if [[ "$1" =~ ^(all|All|-A)$ ]]; then
        modules_install
    else
        jenv_install $@
    fi
}

do_deploy() {
    parse_ostype
    if [[ $# -gt 0 ]]; then
        if has_func deploy_$1 ; then
            deploy_$1 
            echo "Justenv deploy_$1"
        else 
            echo "No deployable config for $1"
        fi
    else
        MSG+=(">>> deploying configs")
        cd $CONFIG_PATH
        deploy_configs
        [[ -f $CONFIG_PATH/after_deploy.sh ]] && . $CONFIG_PATH/after_deploy.sh && MSG+=(">>> exec after_deploy")
        cd $ENV
    fi
}

do_test() {
    deploy_other
}

main() {
    opt=$1
    shift
    case $opt in
        install)
            do_install $@
            ;;
        setup)
            modules_install
            do_deploy
            [[ "$zsh" =~  ^(y|r)$ ]] && zsh
            ;;
        deploy)
            do_deploy $@
            ;;
        uninstall)
            echo "Not implemented"
            ;;
        test)
            do_test $@
            ;;
        func)
            $@
            ;;
        *)
            usage
            exit 0
            ;;
    esac
    clean_up
}

main $@
