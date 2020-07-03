# man pages - archlinux colours and 80 cols
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

# History configuration
export HISTFILE=~/.history
export HISTSIZE=10000
export SAVEHIST=10000
setopt append_history
setopt extended_history
setopt inc_append_history
setopt hist_save_by_copy
setopt share_history

# Builtin zsh plugins
autoload -U colors && colors
autoload -Uz compinit && compinit


# Line editing
bindkey -v                     # vi mode
bindkey jk vi-cmd-mode         # bind jk to esc like in vim
setopt interactivecomments     # Allow comments with a # in a interactive shell
bindkey '^R' history-incremental-search-backward # reinstate Ctrl-r
bindkey "^Q" push-input        # Ctrl-Q will save a long line to history and
                               # clear the line without running the command
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1            # reduce the timeout switching modes

# fzf support
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

#
# PROMPT
#

# Git status prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

### git: Show marker (T) if there are untracked files in repository
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='T'
    fi
}

# Check the repository for changes so they can be used in %u/%c (see
# below). This comes with a speed penalty for bigger repositories.
zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*' get-revision true

# Format string for the vcs info
zstyle ':vcs_info:git*' formats "%{%F{214}%}%s%{$reset_color%} %{$fg[red]%}%b %{$reset_color%}%m%{%F{220}%}%u%{%F{118}%}%c%{%F{123}%}%a%{$reset_color%}"
#
# Display vi mode on right
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
  zle reset-prompt
}

PROMPT="%{%F{214}%}λ%{$reset_color%} %~/%{$reset_color%} \$vcs_info_msg_0_ »%{$reset_color%} "

# Less source code highlighting
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
alias less='COLUMNS=80 less -m -N -g -i -J --underline-special --SILENT'
alias more='less'

#
# ls
#

# ls colors
DIRCOLORS=/home/raoul/gruvbox.dir_colors
test -r ${DIRCOLORS} && eval "$(dircolors ${DIRCOLORS})"

ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }
alias ll='ls -lasph'
alias la='ls -lasph'

# Use LS_COLORS for autompoletion too
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Completion settings
COMPLETION_WAITING_DOTS="true"
setopt NO_BEEP
setopt MENU_COMPLETE
bindkey '^I' expand-or-complete-prefix   # Keep rest of line when completing
bindkey '\M-\C-I' reverse-menu-complete  # Alt-tab to reverse cycle completions
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

export BAT_THEME=gruvbox

# Aliases
alias ack="ag"
alias g='git'
alias k='kubectl'
alias t='terraform'
alias docker-kill-all='docker kill $(docker ps -q)'
alias cat="bat"
# Special alias for managing dotfiles in home dir with git and avoiding clashes
# See https://wiki.archlinux.org/index.php/Dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
eval "$(hub alias -s)"

export CLOUDSDK_PYTHON=`which python2`
export PYTHONSTARTUP=~/.pythonrc

#
# Private environment variables
#
if [ -f $HOME/.priv-env ]; then
  source $HOME/.priv-env

fi

export NVS_HOME="$HOME/.nvs"
[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/raoul/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/raoul/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/raoul/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/raoul/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Show the git status of config files on every interactive login
if [[ -n "$(config st)" ]]; then
  echo "Config is dirty:"
  config st
fi
