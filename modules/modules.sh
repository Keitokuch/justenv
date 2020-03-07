if [[ $zsh == "y" ]]; then
    . $MODULE/zsh.sh
fi

if [[ $tmux == "y" ]]; then
    . $MODULE/tmux.sh
fi

if [[ $nvim == "y" ]]; then
    . $MODULE/nvim.sh
fi
