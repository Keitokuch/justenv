# jenv-get Core
# To be sourced from context where JGET is set

declare -a MSG=()
declare -a JENV_PATH=()

JENV=$HOME/jenv
BIN=$JENV/bin
LIB=$JENV/lib
mkdir -p $JENV
mkdir -p $BIN
mkdir -p $LIB

BUILD=$JGET/build
mkdir -p $BUILD

JENV_RC=$HOME/.jenv_profile
SYS_RC=$HOME/.bashrc

. $JGET/utils.sh
. $JGET/config

jenv_setup() {
    for path in "${JENV_PATH[@]}"; do 
        check_append "export PATH=$path:\$PATH" $JENV_RC
    done
    check_append "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$LIB" $JENV_RC
}

jenv_init() {
    JENV_PATH+=("$BIN")
    touch $JENV_RC
    check_append "source $JENV_RC" $SYS_RC
}

jenv_get() {
    app=$1
    shift
    parse_options $@
    shift $(( OPTIND - 1 ))
    _func=_get_$app
    has_func $_func || { _func=get_$app && forced=1 ; } || { MSG+=("$_func not implemented for $OS") ; return 1 ;}
    if [[ $forced ]] || [[ ! -x $(command -v $app) ]]; then
        if $_func ; then
            [[ $silent ]] || MSG+=(">>> installed $app <<<")
        else
            MSG+=("[ ERROR ] Failed to install $app")
        fi
    else
       [[ $silent ]] || MSG+=("=== $app already installed ===")
    fi
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

jenv_after() {
    jenv_setup
    put_msg
    rm -rf $BUILD
}

main() {
    parse_ostype || { jenv_after; exit 1; }
    load_source  || { jenv_after; exit 1; }
}

main
