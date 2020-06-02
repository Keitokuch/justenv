get_prereq
get_update
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
    jenv_get node
    jenv_get ctags
    jenv_get ag
    jenv_get nvim
    get_vimplug
    deploy_nvim
elif [[ $nvim == "r" ]]; then
    jenv_get nvim   -f
    get_vimplug     -f
    jenv_get node   -f
    jenv_get ctags  -f
    jenv_get ag     -f
    deploy_nvim
    deploy_terminfo
fi

if [[ $tmux == "y" ]]; then
    jenv_get tmux -f
    get_tpm
    deploy_tmux
elif [[ $tmux == "r" ]]; then
    jenv_get tmux -f 
    get_tpm -f
    deploy_tmux
fi
