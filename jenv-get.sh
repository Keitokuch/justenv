#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
UTILS=$ENV/utils
JGET=$ENV/jenv_get

BUILD=$ENV/build
JENV=$HOME/jenv
BIN=$JENV/bin
LIB=$JENV/lib
mkdir -p $BUILD
mkdir -p $JENV
mkdir -p $BIN
mkdir -p $LIB

. $UTILS/env_utils.sh
. $SETUP/setup.sh
. $JGET/jenv_core.sh

SYS_RC=$HOME/.bashrc
JENV_RC=$HOME/.jenv_profile

# touch $JENV_RC
# check_append "source $JENV_RC" $SYS_RC

if [[ $OSTYPE == "linux" ]]; then 
    nr_worker=$(nproc)
else
    nr_worker=$(sysctl -n hw.ncpu)
fi

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
            exit 0
            ;;
    esac

    jenv_setup
    put_msg
    rm -rf $BUILD
}

main $@
