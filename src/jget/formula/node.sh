VERSION=v18.0.0


get() {
    local version=${version:-$VERSION}
    local distro=$ostype-x64
    local nodejs=node-$version-$distro
    local lib_nodejs=$JGET/lib/nodejs
    mkdir -p $lib_nodejs
    wget https://nodejs.org/dist/$version/$nodejs.tar.xz    || return
    tar -xJf $nodejs.tar.xz -C $lib_nodejs                  || return
    add_path "$lib_nodejs/$nodejs/bin"
}


exists() {
    has_command node
}
