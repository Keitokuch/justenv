# jenv-get Core
# To be sourced from context where JGET is set

declare -a MSG=()

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

. $JGET/jenv_utils.sh
. $SETUP/setup.sh

jenv_setup() {
    for path in "${JENV_PATH[@]}"; do 
        check_append "export PATH=$path:\$PATH" $JENV_RC
    done
    check_append "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$LIB" $JENV_RC
}

jenv_init() {
    touch $JENV_RC
    check_append "source $JENV_RC" $SYS_RC
}
