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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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

#--------------------------------------------------------
# REMEMBER LAST DIRECTORY ACROSS SESSIONS
#--------------------------------------------------------
# Change to the last accessed directory
if [ -f ~/.lastdir ]; then
	cd "`cat ~/.lastdir`"
fi

#--------------------------------------------------------
# CHANGE DIRECTORY - SHOW LAST MODIFIED OR GIT STATUS
#--------------------------------------------------------
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
PS1="${PS1}${CYAN}⟫ ${GRAY}"
export PS1
PS2="${CYAN}… ${GRAY}"
export PS2

#--------------------------------------------------------
# PATH
#--------------------------------------------------------
PATH="/usr/local/bin:$PATH"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
test -d "${HOME}/bin" && PATH="${HOME}/bin:$PATH"
test -d "${HOME}/code/shell-scripts" && PATH="${HOME}/code/shell-scripts:$PATH"
export PATH
test -x ~/code/shell-scripts/ssh-login && source ~/code/shell-scripts/ssh-login

#--------------------------------------------------------
# SSH aliases
#--------------------------------------------------------
alias refinery-live='ssh root@178.79.183.164'
alias refinery-systest='ssh root@178.79.182.32'
alias linode1='ssh raoul@178.79.152.163'
alias webteamcity='ssh raoul@10.0.10.36'

#--------------------------------------------------------
# Mail
#--------------------------------------------------------
MAIL=~/Maildir/
export MAIL

#--------------------------------------------------------
# SCREEN
#--------------------------------------------------------
# Reattach any detached screens
#--------------------------------------------------------
SCREENS=`screen -ls | grep 'Attached'`
if [ $? -ne "0" ]; then
	screen -S raoul-default -U -R
fi
