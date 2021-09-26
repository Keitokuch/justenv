GDB_VERSION=9.2

get() {
    version=${version:-$GDB_VERSION}
    wget http://ftp.gnu.org/gnu/gdb/gdb-$version.tar.xz || return
    tar xvf gdb-$version.tar.xz
    cd gdb-$version
    mkdir gdbbuild && cd gdbbuild
    ../configure --prefix=$prefix  || return
    make -j $nr_worker          || return
    make install                || return
}

exists() {
    [[ -x $(command -v gdb) ]]
}
