AUTOCONF_VERSION=2.69

get() {
    local version=${version:-$AUTOCONF_VERSION}
    wget http://ftp.gnu.org/gnu/autoconf/autoconf-$version.tar.gz
    tar -xzf autoconf-$version.tar.gz
    cd autoconf-$version
    ./configure --prefix=$prefix
    make -j$nr_worker
    make install
}

exists() {
    has_executable autoconf
}
