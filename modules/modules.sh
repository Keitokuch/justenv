if [[ $zsh == "y" ]]; then
    . ./zsh.sh
fi

if [[ $tmux == "y" ]]; then
    . ./tmux.sh
fi

if [[ $nvim == "y" ]]; then
    . ./nvim.sh
fi
