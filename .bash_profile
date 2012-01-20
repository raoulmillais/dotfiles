# Include .bashrc if it exists
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

[[ -s "/home/raoul/.rvm/scripts/rvm" ]] && source "/home/raoul/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
