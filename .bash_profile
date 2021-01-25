# Include .bashrc if it exists
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

[[ -s "/home/raoul/.rvm/scripts/rvm" ]] && source "/home/raoul/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s /home/raoul/.nvm/nvm.sh ]] && . /home/raoul/.nvm/nvm.sh # This loads NVM

export PATH="$HOME/.cargo/bin:$PATH"
