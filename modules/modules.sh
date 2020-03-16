get_update
get_prereq
get_build

[[ $zsh == "y" ]] && . $MODULE/zsh.sh

[[ $tmux == "y" ]] && . $MODULE/tmux.sh

[[ $nvim == "y" ]] && . $MODULE/nvim.sh
