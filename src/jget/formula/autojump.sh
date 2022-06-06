_profile_source="[[ -s $prefix/etc/profile.d/autojump.sh ]] && source $prefix/etc/profile.d/autojump.sh"

get() {
    git clone https://github.com/wting/autojump.git
    cd autojump
    git checkout wting_default_python3
    ./install.py -p $prefix -d $prefix
    profile_add "$_profile_source"
}

exists() {
    has_executable autojump
}

remove() {
    git clone https://github.com/wting/autojump.git
    cd autojump
    git checkout wting_default_python3
    ./uninstall.py -p $prefix -d $prefix
    profile_remove "$_profile_source"
}
