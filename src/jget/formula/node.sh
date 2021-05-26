VERSION=v12.16.3


get() {
    local version=${version:-$VERSION}
    local distro=$ostype-x64
    local nodejs=node-$version-$distro
    local lib_nodejs=$JGET/lib/nodejs
    mkdir -p $lib_nodejs
    wget https://nodejs.org/dist/$version/$nodejs.tar.xz    || return 1
    tar -xJf $nodejs.tar.xz -C $lib_nodejs                 || return 1 
    add_path "$lib_nodejs/$nodejs/bin"
}


exists() {
    [[ -x $(command -v node) ]] && return 0 || return 1
}
