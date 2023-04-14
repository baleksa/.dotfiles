# History setup
setopt appendhistory
HISTFILE="${HOME}/.cache/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Add completion folder to fpath
[ -d "$ZDOTDIR/completion" ] && fpath+="$ZDOTDIR/completion/"


safe_source "$HOME/.asdf/asdf.sh"
[ -n "$ASDF_DIR" ] && fpath=(${ASDF_DIR}/completions $fpath)

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

# Colors
autoload -Uz colors && colors

# Normal files to source
safe_source "$ZDOTDIR/zsh-exports"
safe_source "$ZDOTDIR/zsh-aliases"

# Source additional organized into files in $ZDOTDIR/conf.d
[ -d "$ZDOTDIR/conf.d" ] && source "$ZDOTDIR"/conf.d/*


# FZF 
safe_source /usr/share/fzf/completion.zsh
safe_source /usr/share/fzf/key-bindings.zsh
# Bind searching to Alt+r because zsh-vim-mode binds Ctr+r to builtin revsearch
bindkey -M emacs '^[r' fzf-history-widget
bindkey -M vicmd '^[r' fzf-history-widget
bindkey -M viins '^[r' fzf-history-widget

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

source <(cod init $$ zsh)

eval "$(zoxide init zsh)"
alias cd=z
# zle reset-prompt is needed to redisplay the shell prompt after executing the zi
# command.
run_zi() {
	zi
	zle reset-prompt
}
zle -N run_zi
bindkey "^[z" run_zi

# Use starship for prompt https://github.com/starship/starship
eval "$(starship init zsh)"

# PLUGINS
#
# This order is important!

safe_source "$ZDOTDIR/zsh-vim-mode"

# Backspace key doesn't work in iserach with this plugins
ZSH_AUTOPAIR_DIR="$GIT_REPOS_DIR/.zsh-autopair"
safe_source "$ZSH_AUTOPAIR_DIR/autopair.zsh"
autopair-init

ZSH_AUTO_SUGG="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
safe_source "$ZSH_AUTO_SUGG"

ZSH_SYNTAX_HIGHLIGHT="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
safe_source "$ZSH_SYNTAX_HIGHLIGHT"
ZSH_HIGHLIGHT_HIGHLIGHTERS+=brackets

ZSH_HISTORY_SUBSTRING_SEARCH="/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
safe_source "$ZSH_HISTORY_SUBSTRING_SEARCH"

