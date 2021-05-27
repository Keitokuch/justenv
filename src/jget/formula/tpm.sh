TPM=$HOME/.tmux/plugins/tpm

exists() {
    [[ -d $TPM ]]
}

get() {
    git clone https://github.com/tmux-plugins/tpm.git $TPM
}
