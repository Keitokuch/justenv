parse_options() {
    #for var in "$@"
    #do
    #    [[ $var == f ]] && forced=1
    #    [[ $var == s ]] && silent=1
    #    [[ $var == v ]] && ver=1
    #    [[ $ver ]] && VERSION=$var
    #done
    unset forced silent VERSION
    local OPTIND
    while getopts ":fsv:" opt ; do
        case $opt in
            f)
                forced=1
                ;;
            s)
                silent=1
                ;;
            v)
                VERSION=$OPTARG
                ;; 
        esac 
    done
}

parse_ostype() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        ostype=linux
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
            OSVER=$VERSION_ID
        else
            MSG+=("Failed: linux distro not recognized.")
            return 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
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
    declare -f $_func > /dev/null
    return $?
}
