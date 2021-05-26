
get() {
    [[ -n $JUSTENV_SRC ]] || { MSG+=("Error in installing justenv. JUSTENV_SRC not set."); return 1; }
    cp $JUSTENV_SRC/justenv $BIN
    cp -rf $JUSTENV_SRC/jget $BIN
}

exists() {
    [[ -x $(command -v justenv) ]]
}
