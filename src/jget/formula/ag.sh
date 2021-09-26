AG_VERSION=2.2.0

get() {
    version=${version:-$AG_VERSION}
    ag=the_silver_searcher-$version
    wget https://geoff.greer.fm/ag/releases/$ag.tar.gz || return
    tar -xf $ag.tar.gz
    cd $ag
    ./configure --prefix=$prefix  || return
    make -j $nr_worker          || return
    make install                || return
}

exists() {
    [[ -x $(command -v ag) ]]
}
