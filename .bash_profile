# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

export LASTDIR="/"
function prompt_command() {
	newdir=`pwd`

	if [ ! "${LASTDIR}" = "${newdir}" ]; then
		ls -Alt | head -7 | sort
	fi

	export LASTDIR=$newdir
}
export PROMPT_COMMAND="prompt_command"

