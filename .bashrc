# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -Al'
alias l='ls -CF'

alias diff='colordiff -u'

alias top='htop'

# git aliases
alias g='git'
alias gs='git status -s'
alias gc='git commit'
alias ga='git add'
alias gd='git diff --color'
alias gpom='git push origin master'
alias gpl='git pull'

alias ng-server='java -cp "`lein classpath`" vimclojure.nailgun.NGServer 127.0.0.1'
# bash helpers
alias bashmfu='cat ~/.bash_history | sort | uniq -c | sort -g | tail'

# sudo env fix
# alias sudo='sudo env PATH=$PATH'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#--------------------------------------------------------
# LESS COLOURS
#--------------------------------------------------------
# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.less_termcap ]] && . ~/.less_termcap

#--------------------------------------------------------
# PROMPT
#--------------------------------------------------------
GRAY='\[\e[0;37m\]'
BLUE='\e[1;34m'
GOLD='\[\e[0;33m\]'
CYAN='\[\e[1;36m\]'
GREEN='\[\e[0;32m\]'
RED='\[\e[1;31m\]'
YELLOW='\[\e[1;33m\]'
WHITE='\e[1;37m'

export HISTIGNORE="&:ls:[bf]g:exit"

HOME="/home/raoul"
export EDITOR="vim"

# Change to the last accessed directory
if [ -f ~/.lastdir ]; then
	cd "`cat ~/.lastdir`"
fi

export LASTDIR="/"
function prompt_command() {
	newdir=`pwd`

	if [ ! "${LASTDIR}" = "${newdir}" ]; then
		# Remember the new directory
		pwd > ~/.lastdir

		if [ -d ./.git ]; then
			# Show git status if the new dir is a repository
			git status
		else
			# Show 7 most receently accessed files
			ls -Alt --color=always | head -7 | sort
		fi

		# Update the screen title if we're in a screen session
		if expr match "${TERM}" "\(screen\)" > /dev/null; then
			local HPWD="${newdir}"
			case $HPWD in
				"${HOME}")
					HPWD="~"
					;;
				"${HOME}/*")
					HPWD="~${HPWD#HOME}"
					;;
				*)
					HPWD=`basename "${HPWD}"`
					;;
			esac

			printf '\ek%s\e\\' "${HPWD}"
		fi
	fi

	export LASTDIR=$newdir
}
#return value visualisation
PROMPT_COMMAND='RET=$?;'
RET_VALUE='$(if [[ $RET = 0 ]]; then echo -ne "${GREEN} ${RET}"; else echo -ne "${RED} ${RET}"; fi;) '
export PROMPT_COMMAND="${PROMPT_COMMAND} prompt_command;"
RED='\e[0;31m'
GREEN='\e[0;32m'
PS1="${GRAY}[\$(date +%H:%M)]"                    # Current time
PS1="${PS1}${RET_VALUE}"                          # Last Exit code
PS1="${PS1}${BLUE}\u"                             # Username
PS1="${PS1}${GRAY}@"                              # @
PS1="${PS1}${CYAN}\h "                            # Hostname
PS1="${PS1}${GRAY}in "                            # in
PS1="${PS1}${WHITE}\w "                           # Working directory
PS1="${PS1}${YELLOW}\$(vcprompt)\n"               # Version control status
PS1="${PS1}${GRAY}$ "
export PS1
#--------------------------------------------------------
# SCREEN
#--------------------------------------------------------
export SCREEN_CONF_DIR="${HOME}/screenconfig"
export SCREEN_CONF='clean'

#--------------------------------------------------------
# PATH
#--------------------------------------------------------
PATH="/usr/local/bin:$PATH"
test -d "${HOME}/bin" && PATH="${HOME}/bin:$PATH"
test -d "${HOME}/code/shell-scripts" && PATH="${HOME}/code/shell-scripts:$PATH"
export PATH
source ~/code/shell-scripts/ssh-login

#--------------------------------------------------------
# SSH aliases
#--------------------------------------------------------
alias refinery-live='ssh root@178.79.183.164'
alias refinery-systest='ssh root@178.79.182.32'
alias linode1='ssh raoul@178.79.152.163'

#--------------------------------------------------------
# Reattach any detached screens
#--------------------------------------------------------
SCREENS=`screen -ls | grep 'Attached'`
if [ $? -ne "0" ]; then
	screen -U -R
fi
