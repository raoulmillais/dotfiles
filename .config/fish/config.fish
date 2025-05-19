if status is-interactive
  # Commands to run in interactive sessions can go here
  # export FLYCTL_INSTALL="/home/raoul/.fly"
  # export PATH="$FLYCTL_INSTALL/bin:$PATH"
  set -gx PATH $PATH ~/bin  ~/.fly/bin

  alias vim nvim
  alias ls 'eza --long --header --group --links --accessed --modified --git'
  alias ll 'eza --long --header --group --links --accessed --modified --git'       # same as ls
  alias la 'eza --long --all --header --group --links --accessed --modified --git' # show hidden files
  alias nvimconf 'cd ~/.config/nvim/'
  alias ack 'rg'
  alias g 'git'
  alias kubectl 'kubecolor'
  alias k 'kubecolor'
  alias t 'terraform'
  alias docker-kill-all 'docker kill $(docker ps -q)'
  alias cat "bat"
# Special alias for managing dotfiles in home dir with git and avoiding clashes
# See https://wiki.archlinux.org/index.php/Dotfiles
  alias c "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
  alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

  # Use tab for auto completion
  bind \t complete
end
alias fly=flyctl
