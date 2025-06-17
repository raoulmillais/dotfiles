fish_add_path -m ~/.bin ~/.npm-global

if status is-interactive
  # Suppress the welcome message
  set fish_greeting

  set -Ux PAGER less
  set -Ux EDITOR nvim
  set -Ux VISUAL nvim

  # Gruvbox dark colours
  set -l gb_bg0_h '#1d2021'
  set -l gb_bg1 '#3c3836'
  set -l gb_bg2 '#504945'
  set -l gb_bg3 '#665c54'
  set -l gb_fg3 '#bdae93'
  set -l gb_fg2 '#d5c4a1'
  set -l gb_fg1 '#ebdbb2'
  set -l gb_fg0 '#fbf1c7'
  set -l gb_red '#fb4934'
  set -l gb_dark_red '#cc241d'
  set -l gb_orange '#fe8019'
  set -l gb_dark_orange '#d65d0e'
  set -l gb_yellow '#fabd2f'
  set -l gb_dark_yellow '#d79921'
  set -l gb_green '#b8bb26'
  set -l gb_dark_green '#98971a'
  set -l gb_aqua '#8ec07c'
  set -l gb_dark_aqua '#689d6a'
  set -l gb_blue '#83a598'
  set -l gb_dark_blue '#458588'
  set -l gb_purple '#d3869b'
  set -l gb_dark_purple '#b16286'

  set -Ux fifc_custom_fzf_opts "--bind='ctrl-y:accept'
  --bind='ctrl-alt-y:yank'
  --height=40%
  --layout=reverse
  --style=minimal
  --info=inline --border --margin=1 --padding=1
  --color=fg:$gb_fg3,header:$gb_blue,info:$gb_yellow,pointer:$gb_aqua
  --color=bg+:$gb_bg1,bg:$gb_bg0_h,spinner:$gb_aqua,hl:$gb_dark_blue
  --color=marker:$gb_aqua,fg+:$gb_fg1,prompt:$gb_yellow,hl+:$gb_blue"

  theme_gruvbox dark hard

  # Configure vim keybindings (but allow use of emacs style too)
  set -g fish_key_bindings fish_hybrid_key_bindings
  fish_hybrid_key_bindings
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

  # lua rocks
export LUA_PATH='/usr/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua;/usr/share/lua/5.4/?/init.lua;/usr/local/lib/lua/5.4/?.lua;/usr/local/lib/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/raoul/.luarocks/share/lua/5.4/?.lua;/home/raoul/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/usr/local/lib/lua/5.4/?.so;/usr/lib/lua/5.4/?.so;/usr/local/lib/lua/5.4/loadall.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/raoul/.luarocks/lib/lua/5.4/?.so'
export PATH="/home/raoul/.luarocks/bin:$PATH"

  # Make !! behave like bash/zsh
  function last_history_item; echo $history[1]; end
  abbr -a !! --position anywhere --function last_history_item

  # Setup starship prompt
  starship init fish | source
  # Awesome history
  atuin init fish | source
  # Have zoxide replace cd
  zoxide init --cmd cd fish | source
end
