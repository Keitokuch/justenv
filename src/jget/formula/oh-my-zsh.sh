
OMZ=$HOME/.oh-my-zsh

exists() {
    [[ -d $OMZ ]]
}

get() {
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended" 
}
