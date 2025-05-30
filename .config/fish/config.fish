if status is-interactive
  set -Ux PAGER less
  set -Ux EDITOR nvim
  set -Ux VISUAL nvim

  theme_gruvbox dark hard

  # Awesome history
  atuin init fish | source

  # Configure vim keybindings (but allow use of emacs style too)
  set -g fish_key_bindings fish_hybrid_key_bindings
  # Remap jk to escape in insert mode
  bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

  # Commands to run in interactive sessions can go here
  # export FLYCTL_INSTALL="/home/raoul/.fly"
  # export PATH="$FLYCTL_INSTALL/bin:$PATH"
  set -gx PATH $PATH ~/bin  ~/.fly/bin

  # Arch
  alias upd 'sudo pacman -Syu'
  alias srch 'pacman -Ss'
  alias inst 'sudo pacman -S'

  # Vim
  alias vim nvim
  alias nvimconf 'cd ~/.config/nvim/'

  # ls / eza
  alias ls 'eza --long --header --group --links --accessed --modified --git'
  alias ll 'eza --long --header --group --links --accessed --modified --git'       # same as ls
  alias la 'eza --long --all --header --group --links --accessed --modified --git' # show hidden files

  alias ack 'rg'

  alias g 'git'

  # Infrastructure
  alias kubectl 'kubecolor'
  alias k 'kubecolor'
  alias t 'terraform'
  alias docker-kill-all 'docker kill (docker ps -q)'
  alias docker-rm-all 'docker rm -vf (docker ps -aq)'
  alias docker-rmi-all 'docker rmi -f (docker images -aq)'

  alias cat "bat"

# Special alias for managing dotfiles in home dir with git and avoiding clashes
# See https://wiki.archlinux.org/index.php/Dotfiles
  alias c "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
  alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

  alias fly flyctl

  # Use tab for auto completion
  bind \t complete

  # Make !! behave like bash/zsh
  function last_history_item; echo $history[1]; end
  abbr -a !! --position anywhere --function last_history_item

  # Setup starship prompt
  starship init fish | source
end
