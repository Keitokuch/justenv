#local ret_status="%{$FG[215]%}❄ "
# PROMPT='${ret_status}%* %{$FG[087]%}%c: %{$FG[194]%}[$(git_prompt_info)%{$FG[194]%}] %{$reset_color%}$ '
# PROMPT='%{$FG[215]%}❄ %* %{$FG[087]%}%c: $(git_prompt_info)%{$FG[047]%}♨  '

#PROMPT='%{$FG[215]%}❄ %* %{$FG[087]%}%~: $(git_prompt_info)%{$FG[047]%}%{$reset_color%}♨  '
#PROMPT='%{$FG[215]%}❄ %n@%m %{$FG[087]%}%~: $(git_prompt_info)%{$FG[047]%}%{$reset_color%}♨  '
if [[ -z $TMUX ]]; then
	PROMPT='%{$FG[215]%}❄ %m %{$FG[081]%}%~: $(git_prompt_info)%{$FG[047]%}%{$reset_color%}♨  '
else 
	PROMPT='%{$FG[215]%}❄ %m %{$FG[081]%}%c: $(git_prompt_info)%{$FG[047]%}%{$reset_color%}♨  '
fi

# if [[ -z $TMUX ]]; then
# 	PROMPT='%{$FG[215]%}❄ %n %{$FG[087]%}%~: $(git_prompt_info)%{$FG[047]%}%{$reset_color%}♨  '
# else 
# 	PROMPT='%{$FG[215]%}❄ %n %{$FG[087]%}%c: $(git_prompt_info)%{$FG[047]%}%{$reset_color%}♨  '
# fi

# ZSH_THEME_GIT_PROMPT_PREFIX=""
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[225]%}[%{$FG[219]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="*%{$FG[254]%}]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[225]%}]"

# function git_prompt_info() {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return

#   # Checks if working tree is dirty
#   local STATUS=''
#   local FLAGS
#   FLAGS=('--porcelain')
#   if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
#     if [[ $POST_1_7_2_GIT -gt 0 ]]; then
#       FLAGS+='--ignore-submodules=dirty'
#     fi
#     if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
#       FLAGS+='--untracked-files=no'
#     fi
#     STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
#   fi

#   if [[ -n $STATUS ]]; then
#     GIT_PROMPT_COLOR="$ZSH_THEME_GIT_PROMPT_DIRTY"
#     GIT_DIRTY_STAR="*"
#   else
#     GIT_PROMPT_COLOR="$ZSH_THEME_GIT_PROMPT_CLEAN"
#     unset GIT_DIRTY_STAR
#   fi

#   echo "$GIT_PROMPT_COLOR$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$GIT_DIRTY_STAR$ZSH_THEME_GIT_PROMPT_SUFFIX"
# }



