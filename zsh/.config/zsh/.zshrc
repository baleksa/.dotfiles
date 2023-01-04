# History setup
setopt appendhistory
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

# Add completion folder to fpath
[ -d "$ZDOTDIR/completion" ] && fpath+="$ZDOTDIR/completion/"


# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# Print unicode combined characters as a single glyph
setopt combiningchars

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

autoload -Uz add-zsh-hook

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
safe_source "$ZDOTDIR/zsh-exports"
safe_source "$ZDOTDIR/zsh-vim-mode"
safe_source "$ZDOTDIR/zsh-aliases"

# Source additional organized into files in $ZDOTDIR/conf.d
[ -d "$ZDOTDIR/conf.d" ] && source "$ZDOTDIR"/conf.d/*

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
  git clone https://github.com/hlissner/zsh-autopair "$ZSH_AUTOPAIR_DIR"
fi
safe_source "$ZSH_AUTOPAIR_DIR/autopair.zsh"
autopair-init




# Key-bindings
bindkey -s '^f' 'lf^M'
bindkey -s '^v' 'nvim '
bindkey -s '^z' 'zi^M'
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
bindkey -r "^u"
bindkey -r "^d"

# FZF 
safe_source /usr/share/fzf/completion.zsh
safe_source /usr/share/fzf/key-bindings.zsh


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

eval "$(zoxide init zsh)"

# Use starship for prompt https://github.com/starship/starship
eval "$(starship init zsh)"
