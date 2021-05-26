
get() {
    git clone git://github.com/wting/autojump.git
    cd autojump
    ./install.py
}

exists() {
    [[ -x $(command -v autojump) ]]
}
