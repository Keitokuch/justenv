#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
JGET=$ENV/jenv-get

. $ENV/justenv.config
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
        jenv_get $@
        shift $(( OPTIND ))
    done
}

do_test() {
    deploy_other
}

main() {
    check_jenv || jenv_init

    opt=$1
    shift

    case $opt in
        install)
            global_options $@
            shift $(( OPTIND - 1 ))
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

    jenv_after
}

main $@
