# History setup
setopt APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.

# Useful Functions
source "$ZDOTDIR/utils.zsh"

# Add completion folder to fpath
[ -d "$ZDOTDIR/completion" ] && fpath+="$ZDOTDIR/completion/"

fpath+="${ZPLUGDIR}/zsh-completions/src"

source "$HOME/.asdf/asdf.sh"
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
source "${ZDOTDIR}/completion.zsh"
# autoload -Uz compinit
# zstyle ':completion:*' menu select
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#
# zstyle ':completion::complete:lsof:*' menu yes select
# compinit
# _comp_options+=(globdots)		# Include hidden files.

# Colors
autoload -Uz colors && colors

# Normal files to source
source "$ZDOTDIR/aliases.zsh"

# Source additional organized into files in $ZDOTDIR/conf.d
[ -d "$ZDOTDIR/conf.d" ] && source "$ZDOTDIR"/conf.d/*


# FZF 
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
# Bind searching to Alt+r because zsh-vim-mode binds Ctr+r to builtin revsearch
bindkey -M emacs '^[r' fzf-history-widget
bindkey -M vicmd '^[r' fzf-history-widget
bindkey -M viins '^[r' fzf-history-widget

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

#  PLUGINS
#
# This order is important!

source "${ZPLUGDIR}/zsh-bd/bd.zsh"

# Backspace keybindings must go after loading zsh-autopair plugin. That's done
# in vim-mode plugin
source "${ZPLUGDIR}/zsh-autopair/autopair.zsh"
autopair-init

# Must be loaded after zsh-autopair in order for some keybindings (backspace,
# etc.) to work.
source "${ZDOTDIR}/zsh-vim-mode-no-dep.zsh"

source "${ZPLUGDIR}/zsh-autosuggestions/zsh-autosuggestions.zsh" 

source "${ZPLUGDIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_HIGHLIGHTERS+=brackets

# https://github.com/zsh-users/zsh-history-substring-search
source "${ZPLUGDIR}/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[k'  history-substring-search-up
bindkey '^[j' history-substring-search-down
bindkey -M vicmd '^[k' history-substring-search-up
bindkey -M vicmd '^[j' history-substring-search-down
# Bind up and down arrow keys using portable ${terminfo[]} way
# up=kcuu1 down=kcud1 .
# ${terminfo[]} doesn't work on my Void system so using hardcoded values for 
# up and down arrows
bindkey "^[[A"  history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd "^[[A" history-substring-search-up
bindkey -M vicmd "^[[B" history-substring-search-down
