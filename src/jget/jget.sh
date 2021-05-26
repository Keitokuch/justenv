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
declare -ga JGET_RM_PATH=()
JGET_PATH+=("$BIN")

BUILD=$JGET/build
mkdir -p $BUILD

JGET_PROFILE=~/.jget_profile
BASH_PROFILE=$([[ -f ~/.profile ]] && echo "$HOME/.profile" || echo "$HOME/.bash_profile")
ZSH_PROFILE=~/.zshenv
SYS_RC=($BASH_PROFILE $ZSH_PROFILE)

jget_path=$JGET/.paths
jget_libpath=$JGET/.libpaths

. $SRC/utils.sh
. $SRC/config
FORMULA=$SRC/formula

check_jget() {
    [[ -f $JGET_PROFILE ]] && return 0
    return 1
}

add_path() {
    JGET_PATH+=($1)
}

remove_path() {
    JGET_RM_PATH+=($1)
}

jget_setup() {
    for path in "${JGET_PATH[@]}"; do 
        check_append $path $jget_path
    done

    for path in "${JGET_RM_PATH[@]}"; do
        remove_line $path $jget_path
        remove_line $path $JGET_PROFILE
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

jget_remove() {
    global_options $@
    shift "$(( OPTIND - 1 ))"

    while (( ${#@} > 0 ))
    do
        jget_rm_one $@
        shift "$OPTIND"
    done
}

jget_one() {
    local dir=$(pwd)
    local target=$1 && shift
    parse_options $@ 
    local forced=$_forced
    local silent=$_silent
    local optind=$OPTIND
    local formula="$FORMULA/$target.sh"
    source $formula 2>/dev/null || { MSG+=("[ ERROR ] Formula for $target not found"); return; }
    [[ -n $(command -v get) ]] || { MSG+=("[ ERROR ] Formula for $target is broken: get() not provided"); return; }
    [[ -n $(command -v exists) ]] || { MSG+=("[ERROR ] Formula for $target is broken: exists() not provided"); return; }
    if ! exists || [[ $forced ]] || [[ $version ]] ; then
        cd $BUILD
        if get; then
            [[ $silent ]] || MSG+=(">>> installed $target <<<")
        else
            MSG+=("[ ERROR ] Failed to install $target")
        fi
        cd $dir
    else
       [[ $silent ]] || MSG+=("=== $target already installed ===")
    fi
    # global variable position can be changed by nested calls
    OPTIND=optind
}

jget_rm_one() {
    local dir=$(pwd)
    local target=$1 && shift
    parse_options $@ 
    local silent=$_silent
    local optind=$OPTIND
    local func=_rm_$target
    has_func $func || { func=rm_$target ; forced=1 ; has_func $func ; } || { MSG+=("$func not implemented for $os") ; return 1 ;}
    if [[ -x $(command -v $target) ]]; then
        cd $BUILD
        if $func ; then
            [[ $silent ]] || MSG+=(">>> removed $target <<<")
        else
            MSG+=("[ ERROR ] Failed to uninstall $target")
        fi
    else
       [[ $silent ]] || MSG+=("=== $target not installed ===")
    fi
    # global variable position can be changed by nested calls
    OPTIND=optind
    cd $dir
}

load_source() {
    . $SRC/generic.sh
    if [[ $ostype == "linux" ]]; then 
        nr_worker=$(nproc)
        . $SRC/linux.sh
        case $os in
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
                MSG+=("Failed: linux distro $os not supported.")
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
