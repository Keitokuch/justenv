
exists() {
    [[ -f  ~/.local/share/nvim/site/autoload/plug.vim ]] &&
        [[ ! -f  ~/.vim/autoload/plug.vim ]]
}

get() {
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

}
