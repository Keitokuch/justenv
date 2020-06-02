#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
JGET=$ENV/jenv-get

. $JGET/jenv_core.sh

usage() {
    echo "Usage: $0 install [-f] PACKAGE"
}

check_jenv() {
    [[ -f $JENV_RC ]] && return 0
    return 1
}

do_install() {
    while (( $# > 0 )) 
    do
        jenv_get $1
        shift
    done
}

do_test() {
    jenv_get tmux -f
}

main() {
    check_jenv || jenv_init

    opt=$1
    shift

    case $opt in
        install)
            parse_options $@
            do_install $@
            ;;
        test)
            do_test $@
            ;;
        *)
            usage
            exit 0
            ;;
    esac

    jenv_after
}

main $@
