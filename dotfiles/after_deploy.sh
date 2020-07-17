cp -f scripts/cpu_usage.sh ~/.tmux/cpu_usage.sh
cp -f scripts/mem_usage.sh ~/.tmux/mem_usage.sh
tic -o $HOME/.terminfo terminfo/tmux.terminfo
tic -o $HOME/.terminfo terminfo/tmux-256color.terminfo
tic -o $HOME/.terminfo terminfo/xterm-256color.terminfo
git config --global include.path ~/.gitconfig.shared
