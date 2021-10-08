
exists() {
    [[ -x $(command -v fzf) ]]
}

get() {
    git clone --depth 1 https://github.com/junegunn/fzf.git $prefix/fzf
    XDG_CONFIG_HOME=$prefix $prefix/fzf/install --xdg --all
    profile_add "[ -f $prefix/fzf/fzf.zsh ] && source $prefix/fzf/fzf.zsh"
}

remove() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ./fzf
    XDG_CONFIG_HOME=$prefix ./fzf/uninstall --xdg
}
