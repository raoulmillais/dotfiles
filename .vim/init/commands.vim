vim9script noclear

# Automate resizing tabs
# See http://vimcasts.org/episodes/tabs-and-spaces/
command! -nargs=* Stab call tabs#Stab()
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

# Convenient command to see the difference between the current buffer and the
# file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
	  \ | wincmd p | diffthis
