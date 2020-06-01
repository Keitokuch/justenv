#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
UTILS=$ENV/utils
JGET=$ENV/jenv-get

. $UTILS/env_utils.sh
. $SETUP/setup.sh
. $JGET/jenv_core.sh

if [[ $OSTYPE == "linux" ]]; then 
    nr_worker=$(nproc)
else
    nr_worker=$(sysctl -n hw.ncpu)
fi

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
        pkg_name=$1
        shift
        jenv_get $pkg_name -f
    done
}

main() {
    check_jenv || jenv_init

    opt=$1
    shift

    case $opt in
        install)
            do_install $@
            ;;
        *)
            usage
            exit 0
            ;;
    esac

    jenv_setup
    put_msg
    rm -rf $BUILD
}

main $@
