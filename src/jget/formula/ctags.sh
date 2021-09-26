
exists() {
    [[ -x $(command -v ctags) ]]
}

get() {
    local build=ctags
    mkdir -p $build 
    git clone https://github.com/universal-ctags/ctags.git $build   || return
    cd $build
    ./autogen.sh                        || return
    ./configure --prefix=$prefix          || return
    make -j $nr_worker                  || return
    make install                        || return
}
