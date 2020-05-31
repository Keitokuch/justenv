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
