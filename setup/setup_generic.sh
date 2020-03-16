#! /usr/bin/env bash 

OMZ=~/.oh-my-zsh
TMP=~/.tmux/plugins


# get oh-my-zsh
get_OMZ() {
    parse_options $@
    if [[ $forced ]] || [[ ! -d $OMZ ]]; then
        sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended" 
       [[ $silent ]] ||  MSG+=(">>> installed oh-my-zsh <<<")
    else
       [[ $silent ]] || MSG+=("=== oh-my-zsh already installed ===")
    fi
}

get_vimplug() {
    parse_options $@
    if [[ $forced ]] || [[ ! -f  ~/.local/share/nvim/site/autoload/plug.vim ]]; then 
        [[ $silent ]] || MSG+=(">>> installing vim-plug <<<")
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        [[ $silent ]] || MSG+=("=== vim-plug already installed ===")
    fi 
}


deploy_zsh() {
    MSG+=(">>> deploying zsh configs")
    ln -sf $THEME/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
    [[ -f ~/.zshrc ]] && cp ~/.zshrc $JUSTENV/zshrc.old
    ln -sf $CONFIG/zshrc ~/.zshrc
    if [[ -f $CONFIG/zshrc.$OS ]]; then
        ln -sf $CONFIG/zshrc.$OS ~/.zshrc.native
    fi
}

deploy_tmux() {
    MSG+=(">>> deploying tmux configs")
    [[ -f ~/.tmux.conf ]] && cp ~/.tmux.conf $JUSTENV/tmux.conf.old
    ln -sf $CONFIG/tmux.conf ~/.tmux.conf
    mkdir -p ~/.tmux
    ln -sf $CONFIG/tmux.remote.conf ~/.tmux/tmux.remote.conf
    cp -f $SCRIPT/cpu_usage.sh ~/.tmux/cpu_usage.sh
    cp -f $SCRIPT/mem_usage.sh ~/.tmux/mem_usage.sh
}

deploy_nvim() {
    MSG+=(">>> deploying nvim configs")
    mkdir -p ~/.config/nvim/
    [[ -f ~/.config/nvim/init.vim ]] && cp ~/.config/nvim/init.vim $JUSTENV/init.vim.old
    ln -sf $CONFIG/init.vim ~/.config/nvim/init.vim

    # vim colorscheme
    mkdir -p ~/.config/nvim/colors/
    cp $THEME/*.vim ~/.config/nvim/colors/
}

deploy_vim() {
    MSG+=(">>> deploying vim configs")
    mkdir -p ~/.config/nvim/
    cp $DOTFILE/vimrc ~/.vimrc
    cp $DOTFILE/init.vim ~/.config/nvim/init.vim 

    # vim colorscheme
    mkdir -p ~/.vim/colors/ 
    mkdir -p ~/.config/nvim/colors/
    cp $THEME/vim-keitoku.vim ~/.vim/colors/ 
    cp $THEME/vim-keitoku.vim ~/.config/nvim/colors/
}

deploy_configs() {
    deploy_zsh
    deploy_tmux
    deploy_vim
}


get_invalid() {
    MSG+=("$1: setup for $OS not implemented.")
}
get_build() { 
    get_invalid ${FUNCNAME[0]} 
}
get_update()  {
    get_invalid ${FUNCNAME[0]} 
}
get_prereq() {
    get_invalid ${FUNCNAME[0]}
}
get_curl() {
    get_invalid ${FUNCNAME[0]}
}
get_zsh() {
    get_invalid ${FUNCNAME[0]}
}
get_nvim() {
    get_invalid ${FUNCNAME[0]}
}
get_nodejs() {
    get_invalid ${FUNCNAME[0]}
}
get_tmux() {
    get_invalid ${FUNCNAME[0]}
}
get_python3() {
    get_invalid ${FUNCNAME[0]}
}
get_ranger() {
    get_invalid ${FUNCNAME[0]}
}
get_ctags() {
    get_invalid ${FUNCNAME[0]}
}
get_ag() {
    get_invalid ${FUNCNAME[0]}
}

