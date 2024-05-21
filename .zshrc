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

# Load completions
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

function dev() {
  cd ~/code/$1
}

# Line editing
export KEYTIMEOUT=10            # reduce the timeout switching modes
setopt interactivecomments     # Allow comments with a # in a interactive shell
bindkey -v                     # vi mode
bindkey -M viins '^R' history-incremental-search-backward # Ctrl-r to search history
bindkey -M viins 'jk' vi-cmd-mode    # Bind jk to esc like in nvim
bindkey -M viins '^Q' push-input   # Save line to history and clear line
bindkey -s '^O' 'nvim $(fzf)\n'     # Use Ctrl-O to interactively open a file in nvim

# "Fixes" for Filco USB keyboard in vi-cmd-mode ("normal" mode)
# Make special keys behave more like in insert mode
bindkey -M vicmd '^[[1~' vi-first-non-blank # Fix home key behave like "^"
bindkey -M vicmd '^[[4~' vi-end-of-line     # Fix end key behave like "$"
bindkey -M vicmd '^[[3~' vi-delete-char     # Make del key behave like "x" in nvim

zle -N zle-line-init
zle -N zle-keymap-select

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

#
# Nvim
#
alias vim=nvim

# Less source code highlighting
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
alias less='COLUMNS=80 less -m -N -g -i -J --underline-special --SILENT'
alias more='less'

#
# ls / eza
#

# ls colors
DIRCOLORS=/home/raoul/gruvbox.dir_colors
test -r ${DIRCOLORS} && eval "$(dircolors ${DIRCOLORS})"
alias ls='eza --long --header --group --links --accessed --modified --git'
alias ll='eza --long --header --group --links --accessed --modified --git'       # same as ls
alias la='eza --long --all --header --group --links --accessed --modified --git' # show hidden files

# Use LS_COLORS for autompoletion too
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Completion settings
COMPLETION_WAITING_DOTS="true"
setopt NO_BEEP
setopt MENU_COMPLETE
bindkey '^I' expand-or-complete-prefix   # Keep rest of line when completing
bindkey '\M-\C-I' reverse-menu-complete  # Alt-tab to reverse cycle completions

export BAT_THEME=gruvbox-dark


#
# fzf
#

# gruvbox colors
FZF_DEFAULT_OPTS="--color=bg+:#3c3836,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934"
# layout
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --height 40% --layout=reverse --border"

# prefer ripgrep to find
export FZF_DEFAULT_COMMAND='rg --files --follow'

# Aliases
alias nvimconf='cd ~/.config/nvim/'
alias ack='rg'
alias g='git'
alias kubectl='kubecolor'
alias k='kubecolor'
alias t='terraform'
alias docker-kill-all='docker kill $(docker ps -q)'
alias cat="bat"
# Special alias for managing dotfiles in home dir with git and avoiding clashes
# See https://wiki.archlinux.org/index.php/Dotfiles
alias c="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
eval "$(hub alias -s)"

export CLOUDSDK_PYTHON=`which python2`
export PYTHONSTARTUP=~/.pythonrc

export GPG_TTY=$(tty)

#
# Private environment variables
#
if [ -f $HOME/.priv-env ]; then
  source $HOME/.priv-env
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/raoul/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/raoul/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/raoul/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/raoul/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

if command -v kubebuilder >/dev/null; then
  source <(kubebuilder completion zsh)
fi

# Show the git status of config files on every interactive login
if [[ -n "$(config st)" ]]; then
  echo "Config is dirty:"
  config st
fi
