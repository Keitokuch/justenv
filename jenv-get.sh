#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
JGET=$ENV/jenv-get

. $JGET/jenv_core.sh

usage() {
    echo "Usage: $0 install PACKAGE"
}

check_jenv() {
    [[ -f $JENV_RC ]] && return 0
    return 1
}

do_install() {
    while (( $# > 0 )) 
    do
        jenv_get $1 -f
        shift
    done
}

do_test() {
    has_lib $1 && echo yes || echo no
}

main() {
    check_jenv || jenv_init

    opt=$1
    shift

    case $opt in
        install)
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
