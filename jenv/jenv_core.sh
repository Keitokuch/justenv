# jenv-get Core
# To be sourced from context where JGET is set

declare -ga JENV_PATH=()

JENV=$HOME/jenv
BIN=$JENV/bin
LIB=$JENV/lib
mkdir -p $JENV
mkdir -p $BIN
mkdir -p $LIB

BUILD=$JENV/build
mkdir -p $BUILD

JENV_RC=$HOME/.jenv_profile
SYS_RC=($HOME/.bash_profile $HOME/.zprofile)

. $JGET/utils.sh
. $JGET/config

check_jenv() {
    [[ -f $JENV_RC ]] && return 0
    return 1
}

jenv_setup() {
    for path in "${JENV_PATH[@]}"; do 
        check_append "export PATH=$path:\$PATH" $JENV_RC
    done
    check_append "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$LIB" $JENV_RC
}

jenv_init() {
    JENV_PATH+=("$BIN")
    touch $JENV_RC
    for profile in "${SYS_RC[@]}"; do 
        check_append "source $JENV_RC" $profile
    done
}

jenv_install() {
    global_options $@
    shift "$(( OPTIND - 1 ))"

    while (( ${#@} > 0 ))
    do
        jenv_get $@
        shift "$OPTIND"
    done
}

jenv_get() {
    local app=$1 && shift
    parse_options $@ 
    local forced=$_forced
    local silent=$_silent
    local optind=$OPTIND
    local func=_get_$app
    has_func $func || { func=get_$app ; forced=1 ; has_func $func ; } || { MSG+=("$func not implemented for $OS") ; return 1 ;}
    if [[ $forced ]] || [[ ! -x $(command -v $app) ]]; then
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
}

load_source() {
    . $JGET/generic.sh
    if [[ $ostype == "linux" ]]; then 
        nr_worker=$(nproc)
        case $OS in
            centos|rhel)
                . $JGET/centos.sh
                ;;
            ubuntu)
                . $JGET/ubuntu.sh
                ;;
            *)
                MSG+=("Failed: linux distro $OS not supported.")
                return 1
                ;;
        esac
    elif [[ $ostype == "darwin" ]]; then
        nr_worker=$(sysctl -n hw.ncpu)
        . $JGET/macos.sh        
    fi
}

terminate() {
    MSG+=("Terminated. Cleaning up...")
    clean_up
    exit 1
}

jenv_before() {
    rm -rf $BUILD/*
    trap terminate SIGINT
    trap terminate SIGTSTP
    CLEANUP=("jenv_after" "${CLEANUP[@]}")
}

jenv_after() {
    jenv_setup
    rm -rf $BUILD
}

main() {
    # check_jenv   || jenv_init
    jenv_init
    jenv_before
    parse_ostype || { jenv_after; exit 1; }
    load_source  || { jenv_after; exit 1; }
}

main
