#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
JGET=$ENV/jenv-get
declare -a MSG=()
declare -a CLEANUP=("put_msg")

. $ENV/justenv.config
. $JGET/jenv_core.sh

usage() {
    echo "Usage: $0 install [-f] PACKAGE"
}

do_install() {
    jenv_install $@
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
