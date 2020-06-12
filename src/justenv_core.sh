declare -a MSG=()

deploy_zsh() {
    MSG+=(">>> deploying zsh configs")
    # ln -sf $THEME/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
    cp $THEME/*.zsh-theme $OMZ/themes/
    [[ -f ~/.zshrc ]] && cp ~/.zshrc $OLD/zshrc.old
    ln -sf $DOTFILE/zshrc ~/.zshrc
    if [[ -f $DOTFILE/zshrc.$OS ]]; then
        ln -sf $DOTFILE/zshrc.$OS ~/.zshrc.native
    fi
}

deploy_tmux() {
    MSG+=(">>> deploying tmux configs")
    [[ -f ~/.tmux.conf ]] && cp ~/.tmux.conf $OLD/tmux.conf.old
    ln -sf $DOTFILE/tmux.conf ~/.tmux.conf
    mkdir -p ~/.tmux
    ln -sf $DOTFILE/tmux.remote.conf ~/.tmux/tmux.remote.conf
    cp -f $SCRIPT/cpu_usage.sh ~/.tmux/cpu_usage.sh
    cp -f $SCRIPT/mem_usage.sh ~/.tmux/mem_usage.sh
}

deploy_nvim() {
    MSG+=(">>> deploying nvim configs")
    mkdir -p ~/.config/nvim/
    [[ -f ~/.config/nvim/init.vim ]] && cp ~/.config/nvim/init.vim $OLD/init.vim.old
    ln -sf $DOTFILE/init.vim ~/.config/nvim/init.vim

    # vim colorscheme
    mkdir -p ~/.config/nvim/colors/
    cp $THEME/*.vim ~/.config/nvim/colors/
}

# Not used
deploy_vim() {
    MSG+=(">>> deploying vim configs")
    mkdir -p ~/.config/nvim/
    cp $DOTFILE/vimrc ~/.vimrc

    # vim colorscheme
    mkdir -p ~/.vim/colors/ 
    mkdir -p ~/.config/nvim/colors/
    cp $THEME/vim-keitoku.vim ~/.vim/colors/ 
}

# deploy_configs() {
#     # deploy_zsh
#     # deploy_tmux
#     # deploy_nvim
#     deploy_other
#     deploy_terminfo
# }

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

deploy_terminfo() {
    cd $SCRIPT/terminfo
    tic -o $HOME/.terminfo tmux.terminfo
    tic -o $HOME/.terminfo tmux-256color.terminfo
    tic -o $HOME/.terminfo xterm-256color.terminfo
    cd $ENV
}
