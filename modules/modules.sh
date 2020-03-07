get_build
get_update

[[ $zsh == "y" ]] && . $MODULE/zsh.sh

[[ $tmux == "y" ]] && . $MODULE/tmux.sh

[[ $nvim == "y" ]] && . $MODULE/nvim.sh
