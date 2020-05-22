#! /usr/bin/env bash 

declare -a JENV_PATH=()

JENV_PATH+=("$BIN")

. $SETUP/setup_generic.sh
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    OSTYPE=linux
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
        if [[ $OS == "centos" ]]; then
            . $SETUP/setup_centos.sh
            . $SETUP/setup_rhel.sh
        elif [[ $OS == "ubuntu" ]]; then
            . $SETUP/setup_ubuntu.sh
        elif [[ $OS == "rhel" ]]; then
            . $SETUP/setup_rhel.sh
        else
            echo "Failed: linux distro $OS not supported."
            exit 1
        fi
    else
        echo "Failed: linux distro not recognized."
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OSTYPE=darwin
    . $SETUP/setup_macos.sh
else
    echo "Failed: OS type $OSTYPE not supported."
    exit 1
fi

jenv_setup() {
    for path in "${JENV_PATH[@]}"; do 
        check_append "export PATH=$path:\$PATH" $JENV_RC
    done
}
