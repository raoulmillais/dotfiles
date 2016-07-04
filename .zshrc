# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="lambda"


man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Beeps are annoying
setopt NO_BEEP

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git grunt npm screen themes node history git-remote-branch archlinux tmux)

source $ZSH/oh-my-zsh.sh

#Theme customisation
PROMPT='%{$fg[blue]%}λ%{$reset_color%} %~/ %{$fg[blue]%}$(git_prompt_info)%{$reset_color%}» '
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%} %{$fg[green]%}✓%{$reset_color%}"
RPS1='[%*]'

# Aliases
alias openproj="gvim -c 'cd '$PWD"
alias vim="nvim"
alias ack="ag"


# Customize to your needs...
export EDITOR=nvim
export VISUAL=nvim

#export NODE_ENV=development
export PATH=./node_modules/.bin:$PATH
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/raoul/.rvm/bin:/home/raoul/bin
export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
export TMUX_POWERLINE_SYMBOLS="vim-powerline"

# "Fix" 256 colors in gnome terminal
if [ "${COLORTERM}"="gnome-terminal" ]; then
	if [[ -z $TMUX ]]; then 
		export TERM=xterm-256color
	else
		export TERM=screen-256color
	fi
fi

# Sensitive config
if [ -f $HOME/.priv-env ]; then
	source $HOME/.priv-env
	
fi

if [[ -z $LS_COLORS  ]]; then
	if [ -f $HOME/.dircolors ]; then
		eval $(dircolors -b $HOME/.dircolors)
	fi
fi

setopt no_share_history
export NVM_DIR="/home/raoul/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# OPAM configuration
. /home/raoul/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

[ -s "/home/raoul/.dnx/dnvm/dnvm.sh" ] && . "/home/raoul/.dnx/dnvm/dnvm.sh" # Load dnvm
