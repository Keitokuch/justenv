
get() {
    [[ -n $JUSTENV_SRC ]] || { git clone https://github.com/Keitokuch/justenv.git ; JUSTENV_SRC=justenv/src ; }
    cp -f $JUSTENV_SRC/justenv $BIN
    cp -rf $JUSTENV_SRC/jget $BIN
}

exists() {
    has_executable justenv
}
