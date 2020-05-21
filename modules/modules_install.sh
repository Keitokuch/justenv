get_update
get_prereq
get_build

if [[ $zsh == "y" ]]; then
    jenv_get zsh
    get_OMZ
    deploy_zsh
elif [[ $zsh == "r" ]]; then
    jenv_get zsh -f
    get_OMZ -f
    deploy_zsh
fi

if [[ $nvim == "y" ]]; then
    jenv_get nvim
    get_vimplug
    jenv_get node
    jenv_get ctags
    jenv_get ag
    deploy_nvim
elif [[ $nvim == "r" ]]; then
    jenv_get nvim   -f
    get_vimplug     -f
    jenv_get node   -f
    jenv_get ctags  -f
    jenv_get ag     -f
    deploy_nvim
fi

if [[ $tmux == "y" ]]; then
    get_tmux -f
    deploy_tmux
fi
