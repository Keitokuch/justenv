#! /usr/bin/env bash 

OS="macos"


get_update() {
    brew update
}


get_ag() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v ag) ]]; then
        brew install the_silver_searcher
        [[ $silent ]] || MSG+=(">>> installed ag <<<")
    else
        [[ $silent ]] || MSG+=("=== ag already installed ===")
    fi 
}

get_zsh() {
    if ! [[ -x $(command -v zsh) ]]; then
        brew install zsh zsh-completions
        if [[ -x "/bin/zsh" ]]; then
            chsh -s "/bin/zsh"
        else 
            chsh -s $(which zsh) 
        fi
        MSG+=(">>> installed zsh <<<")
    else
        MSG+=("=== zsh already installed ===")
    fi 
}


get_curl() {
    if ! [[ -x $(command -v curl) ]]; then
        brew install curl
        MSG+=(">>> installed curl <<<")
    else
        MSG+=("=== curl already installed ===")
    fi 
}


get_nodejs() {
    if ! [[ -x $(command -v node) ]]; then
        brew install node
        MSG+=(">>> installed nodejs <<<")
    else 
        MSG+=("=== nodejs already installed ===")
    fi 
}

