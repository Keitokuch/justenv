AUTOMAKE_VERSION=1.16

exists() {
    has_executable automake
}

get() {
    local version=${version:-$AUTOMAKE_VERSION}
    wget https://ftp.gnu.org/gnu/automake/automake-$version.tar.gz
    tar -xzf automake-$version.tar.gz
    cd automake-$version
    ./configure --prefix=$prefix
    make -j$nr_worker && make install
}

