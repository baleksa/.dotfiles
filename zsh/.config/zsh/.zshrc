HISTFILE="$ZDOTDIR/.zsh_history"
setopt appendhistory
# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP


# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
safe_source "$ZDOTDIR/zsh-exports"
safe_source "$ZDOTDIR/zsh-vim-mode"
safe_source "$ZDOTDIR/zsh-aliases"
# zsh_add_file "zsh-prompt"


# PLUGINS
#
ZSH_SYNTAX_HIGHLIGHT="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
safe_source "$ZSH_SYNTAX_HIGHLIGHT"

ZSH_AUTO_SUGG="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
safe_source "$ZSH_AUTO_SUGG"

ZSH_HISTORY_SUBSTRING_SEARCH="/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
safe_source "$ZSH_HISTORY_SUBSTRING_SEARCH"

# Autopair plugin
ZSH_AUTOPAIR_DIR="$GIT_REPOS_DIR/.zsh-autopair"
if [[ ! -d "$ZSH_AUTOPAIR_DIR" ]]; then
  git clone https://github.com/hlissner/zsh-autopair $ZSH_AUTOPAIR_DIR
fi
safe_source "$ZSH_AUTOPAIR_DIR/autopair.zsh"
autopair-init


# Add completion folder to fpath
[ -d $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"


# Key-bindings
bindkey -s '^o' 'lf^M'
bindkey -s '^f' 'zi^M'
# bindkey -s '^s' 'ncdu^M'
bindkey -s '^n' 'nvim $(fzf)^M'
bindkey -s '^v' 'nvim\n'
bindkey -s '^z' 'zi^M'
# bindkey '^[[P' delete-char
# bindkey "^p" up-line-or-beginning-search # Up
# bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
bindkey -r "^u"
bindkey -r "^d"

# FZF 
# TODO update for mac
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Environment variables set everywhere

alias luamake=/home/baleksa/Repositories/lua-language-server/3rd/luamake/luamake

# For QT Themes
# export QT_QPA_PLATFORMTHEME=qt5ct

# remap caps to escape
# setxkbmap -option caps:escape
# swap escape and caps
# setxkbmap -option caps:swapescape
eval "$(starship init zsh)"



