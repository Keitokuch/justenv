TMP=$HOME/.tmux/plugins

exists() {
    [[ -d "$TMP/tmp" ]]
}

get() {
    git clone https://github.com/tmux-plugins/tpm.git $TMP/tpm
}
