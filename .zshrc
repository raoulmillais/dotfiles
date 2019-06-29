#
# Documentation
#
man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    COLUMNS=80 \
    man "$@"
}

# Zsh config
export HISTFILE=~/.history
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history
setopt extended_history
setopt inc_append_history
setopt hist_save_by_copy
setopt share_history
setopt interactivecomments     # Allow comments with a # in a interactive shell
bindkey '^R' history-incremental-search-backward
bindkey "^Q" push-input        # Ctrl-Q will save a long line to history and
                               # clear the line without running the command

# Vi mode line editing
bindkey -v
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1            # reduce the timeout switching modes


# Less source code highlighting
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
alias less='COLUMNS=80 less -m -N -g -i -J --underline-special --SILENT'
alias more='less'

# ls colors
autoload -U colors && colors
#
# # Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

if [[ -z "$LS_COLORS" ]]; then
  (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi

ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }

# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

alias g='git'
alias k='kubectl'
alias t='terraform'

# Completion settings
COMPLETION_WAITING_DOTS="true"
setopt NO_BEEP
setopt MENU_COMPLETE

bindkey '^I' expand-or-complete-prefix   # Keep rest of line when completing
bindkey '\M-\C-I' reverse-menu-complete  # Alt-tab to reverse cycle completions

PROMPT="%{$fg[blue]%}λ%{$reset_color%} %~/%{$reset_color%} » "

# Aliases
alias ack="ag"

# Docker and triton
alias docker-kill-all='docker kill $(docker ps -q)'
docker-local() {
  unset DOCKER_CERT_PATH
  unset DOCKER_HOST
  unset DOCKER_TLS_VERIFY
}

export EDITOR=vim
export VISUAL=vim

export PATH=./node_modules/.bin:$HOME/go/bin:$HOME/bin:$PATH
export TMUX_POWERLINE_SYMBOLS="vim-powerline"
export CLOUDSDK_PYTHON=`which python2`

export PYTHONSTARTUP=~/.pythonrc

#
# Private environment variables
#
if [ -f $HOME/.priv-env ]; then
  source $HOME/.priv-env

fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/raoul/google-cloud-sdk/path.zsh.inc' ]; then . '/home/raoul/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/raoul/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/raoul/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(hub alias -s)"
export NVS_HOME="$HOME/.nvs"
[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"
