modules_install() {
    JGET=$ENV/jenv
    . $JGET/jenv_core.sh

    jenv_install -s prereq update build

    [[ $zsh == "y" ]] &&  jenv_install zsh OMZ
    [[ $zsh == "r" ]] && jenv_install -f zsh OMZ

    [[ $nvim == "y" ]] &&  jenv_install nvim vim-plug node ctags ag
    [[ $nvim == "r" ]] && jenv_install -f nvim vim-plug node ctags ag

    [[ $tmux == "y" ]] &&  jenv_install tmux -f tpm
    [[ $tmux == "r" ]] && jenv_install -f tmux tpm
}

deploy_configs() {
    while read src dst
    do
        dst=${dst/#~/$HOME}
        dstdir=`dirname "$dst"`
        dstname=`basename "$dst"`
        [[ -f $dst ]] && cp $dst "$OLD/$dstname.old"
        [[ $dst == */ ]] && mkdir -p $dst || mkdir -p $dstdir
        ln -sf $CONFIG_PATH/$src $dst
        echo "softlink $src to $dst"
    done <"$CONFIG_PATH/deploy_path"
}
