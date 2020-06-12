JGET="$ENV/jenv-get.sh install"

$JGET prereq update build

if [[ $zsh == "y" ]]; then
    $JGET zsh OMZ
elif [[ $zsh == "r" ]]; then
    $JGET -f zsh OMZ
fi

if [[ $nvim == "y" ]]; then
    $JGET nvim vim-plug node ctags ag
elif [[ $nvim == "r" ]]; then
    $JGET -f nvim vim-plug node ctags ag
fi

if [[ $tmux == "y" ]]; then
    $JGET tmux -f tpm
elif [[ $tmux == "r" ]]; then
    $JGET -f tmux tpm
fi
