DISABLE_AUTO_UPDATE=true

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
    man "$@"
}

nd() {
    nd 2>/dev/null "$@"
}

# Beeps are annoying
setopt NO_BEEP

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git grunt npm screen themes node history git-remote-branch archlinux tmux)

export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

#Theme customisation
local nvm_info='$(nvm_prompt_info)'
local git_info='$(git_prompt_info)'
ZSH_THEME_NVM_PROMPT_PREFIX="%{$fg[green]%}⬢ "
ZSH_THEME_NVM_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%} %{$fg[green]%}✓%{$reset_color%}"

PROMPT="%{$fg[blue]%}λ%{$reset_color%} %~/ %{$fg[blue]%}${git_info}%{$reset_color%} ${nvm_info}%{$reset_color%} » "
# Aliases
alias openproj="gvim -c 'cd '$PWD"
alias vim="nvim"
alias ack="ag"

# Docker and triton
alias docker-kill-all='docker kill $(docker ps -q)'
docker-local() {
  unset DOCKER_CERT_PATH
  unset DOCKER_HOST
  unset DOCKER_TLS_VERIFY
}

docker-triton() {
  eval "$(triton env)"
}

export EDITOR=nvim
export VISUAL=nvim

export PATH=./node_modules/.bin:$PATH
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/raoul/.rvm/bin:/home/raoul/bin:~/bin
export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
export TMUX_POWERLINE_SYMBOLS="vim-powerline"
export CLOUDSDK_PYTHON=`which python2`

export PYTHONSTARTUP=~/.pythonrc

#
# Private environment variables
#
if [ -f $HOME/.priv-env ]; then
	source $HOME/.priv-env

fi

#
# Nicer colours when running ls
#
if [[ -z $LS_COLORS  ]]; then
	if [ -f $HOME/.dircolors ]; then
#		eval $(dircolors -b $HOME/.dircolors)
	fi
fi

setopt no_share_history
export NVM_DIR="/usr/local/opt/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# OPAM configuration
. /home/raoul/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

[ -s "/home/raoul/.dnx/dnvm/dnvm.sh" ] && . "/home/raoul/.dnx/dnvm/dnvm.sh" # Load dnvm
#
# Cloud Platforms
#

# source "~/.triton.completion"


# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/raoul/Downloads/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/raoul/Downloads/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/raoul/Downloads/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/raoul/Downloads/google-cloud-sdk/completion.zsh.inc'
fi

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Auto install and use correct node via nvm
autoload -U add-zsh-hook
load-nvmrc() {
  local -r node_version="$(nvm version)"
  local -r nvmrc_path="$(nvm_find_nvmrc)"

  if [[ -n "$nvmrc_path" ]] ; then
    local -r nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install > /dev/null
    elif [[ "$nvmrc_node_version" != "$node_version" ]] ; then
      nvm use
    fi
  elif [[ "$node_version" != "$(nvm version default)" ]] ; then
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
