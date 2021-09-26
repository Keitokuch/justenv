SIXEL_VERSION=1.8.6

exists() {
    [[ -x $(command -v libsixel-config) ]] && \
    [[ -x $(command -v img2sixel) ]] && \
    [[ -x $(command -v sixel2png) ]]
}

get() {
    version=${version:-$SIXEL_VERSION}
    wget https://github.com/saitoha/libsixel/releases/download/v$version/libsixel-$version.tar.gz || return
    tar xzvf libsixel-$version.tar.gz
    cd sixel-$version
    ./configure --prefix=$prefix
    make -j$nr_worker
    make install
}
