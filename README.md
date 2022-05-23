# Just my dotfiles

My configuration files for my dev environment on arch linux

## Installation instructions on a new machine

```bash
git clone --bare git@github.com:raoulmillais/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME reset --hard
source .zshrc
c config status.showUntrackedFiles no
```

## Standing on the shoulders of giants fighting dragons

Use at your own risk!  Feel free to peruse and take inspiration from anything
you find useful.  I have done the same from many other colleagues and other 
people on the web.
