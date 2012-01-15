# Include .bashrc if it exists
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Change to the last directory
if [ -f ~/.lastdir ]; then
	cd "`cat ~/.lastdir`"
fi

export LASTDIR="/"
function prompt_command() {
	newdir=`pwd`

	if [ ! "${LASTDIR}" = "${newdir}" ]; then
		pwd > ~/.lastdir
		ls -Alt | head -7 | sort
	fi

	export LASTDIR=$newdir
	echo -n "[$(date +%H:%M)] "
}
export PROMPT_COMMAND="prompt_command"

