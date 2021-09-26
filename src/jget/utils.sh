parse_options() {
    #for var in "$@"
    #do
    #    [[ $var == f ]] && forced=1
    #    [[ $var == s ]] && silent=1
    #    [[ $var == v ]] && ver=1
    #    [[ $ver ]] && VERSION=$var
    #done
    unset _forced _silent version prefix
    OPTIND=1
    while getopts ":fsv:p:" opt ; do
        case $opt in
            f)
                _forced=1
                ;;
            s)
                _silent=1
                ;;
            v)
                version=$OPTARG
                ;; 
            p)
                prefix=$OPTARG
        esac 
    done
    _forced=${_forced:-$FORCED}
    _silent=${_silent:-$SILENT}
    prefix=${prefix:-$PREFIX}
}

global_options() {
    unset FORCED SILENT PREFIX
    OPTIND=1
    while getopts ":fsp:" opt ; do
        case $opt in 
            f)
                FORCED=1
                ;;
            s)
                SILENT=1
                ;;
            p)
                PREFIX=$OPTARG
                ;;
        esac
    done
    PREFIX=${PREFIX:-$JGET}
}

parse_ostype() {
    if [[ $(uname) == "Linux" ]]; then
        ostype=linux
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            os=$ID
            osversion=$VERSION_ID
        else
            MSG+=("Failed: linux distro not recognized.")
            return 1
        fi
    elif [[ $(uname) == "Darwin" ]]; then
        os=macos
        ostype=darwin
    else
        MSG+=("Failed: OS type $OSTYPE not supported.")
        return 1
    fi
}

# display messages
put_msg() {
    for msg in "${MSG[@]}"; do
        echo $msg
    done
}

check_append() {
    grep -qxsF -- "$1" "$2" || echo "$1" >> "$2"
}

remove_line() {
    grep -v "$1" "$2" > temp && mv temp "$2"
}

has_executable() {
    [[ -x $(command -v $1) ]]
}

has_lib() {
    haslib=$(whereis "$1" | wc -w)
    if [[ $haslib -gt 1 ]]; then 
        return 0
    else
        if [[ $(whereis -B "$LIB" -f "$1" | wc -w) -gt 1 ]]; then
            return 0
        else
            return 1
        fi
    fi
}

has_func() {
    declare -f $1 > /dev/null
    return $?
}

clean_up() {
    for tsk in "${CLEANUP[@]}"; do
        $tsk
    done
}
