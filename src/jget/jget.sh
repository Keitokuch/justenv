#! /usr/bin/env bash
# jenv-get Core
# To be sourced from context where JGET is set

SRC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

JGET=$HOME/.jget
BIN=$JGET/bin
LIB=$JGET/lib
MAN=$JGET/share/man
mkdir -p $JGET
mkdir -p $BIN
mkdir -p $LIB

declare -ga JGET_PATH=()
JGET_PATH+=("$BIN")

BUILD=$JGET/build
mkdir -p $BUILD

JGET_PROFILE=~/.jget_profile
SYS_RC=($HOME/.bash_profile $HOME/.zshenv)

jget_path=$JGET/.paths
jget_libpath=$JGET/.libpaths

. $SRC/utils.sh
. $SRC/config

check_jget() {
    [[ -f $JGET_PROFILE ]] && return 0
    return 1
}

jget_setup() {
    for path in "${JGET_PATH[@]}"; do 
        check_append $path $jget_path
    done

    while read path
    do
        check_append "export PATH=$path:\$PATH" $JGET_PROFILE
    done <"$jget_path"

    check_append "export LD_LIBRARY_PATH=$LIB:\$LD_LIBRARY_PATH" $JGET_PROFILE
    check_append "export MANPATH=$MAN:\$MANPATH" $JGET_PROFILE
}

jget_init() {
    touch "$JGET_PROFILE"
    for profile in "${SYS_RC[@]}"; do 
        check_append "source "$JGET_PROFILE"" $profile
    done
    jget_install -s sys_prereq prereq
}

jget_install() {
    global_options $@
    shift "$(( OPTIND - 1 ))"

    while (( ${#@} > 0 ))
    do
        jget_one $@
        shift "$OPTIND"
    done
}

jget_one() {
    local app=$1 && shift
    parse_options $@ 
    local forced=$_forced
    local silent=$_silent
    local optind=$OPTIND
    local func=_get_$app
    has_func $func || { func=get_$app ; forced=1 ; has_func $func ; } || { MSG+=("$func not implemented for $OS") ; return 1 ;}
    if [[ $forced ]] || [[ ! -x $(command -v $app) ]]; then
        cd $BUILD
        if $func ; then
            [[ $silent ]] || MSG+=(">>> installed $app <<<")
        else
            MSG+=("[ ERROR ] Failed to install $app")
        fi
    else
       [[ $silent ]] || MSG+=("=== $app already installed ===")
    fi
    # global variable position can be changed by nested calls
    OPTIND=optind
    cd $SRC
}

load_source() {
    . $SRC/generic.sh
    if [[ $ostype == "linux" ]]; then 
        nr_worker=$(nproc)
        . $SRC/linux.sh
        case $OS in
            centos|rhel)
                . $SRC/centos.sh
                ;;
            ubuntu)
                . $SRC/ubuntu.sh
                ;;
            debian)
                . $SRC/debian.sh
                ;;
            *)
                MSG+=("Failed: linux distro $OS not supported.")
                return 1
                ;;
        esac
    elif [[ $ostype == "darwin" ]]; then
        nr_worker=$(sysctl -n hw.ncpu)
        . $SRC/macos.sh        
    fi
}

terminate() {
    MSG+=("Terminated. Cleaning up...")
    clean_up
    exit 1
}

jget_before() {
    rm -rf $BUILD/*
    trap terminate SIGINT
    trap terminate SIGTSTP
    CLEANUP=("jget_after" "${CLEANUP[@]}")
}

jget_after() {
    jget_setup
    rm -rf $BUILD
}

main() {
    # check_jget   || jget_init
    parse_ostype
    load_source 
    jget_init
    jget_before
}

main
