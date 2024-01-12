export ZPLUGDIR="$ZDOTDIR"/plugins

# History setup
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/history # History filepath
export HISTSIZE=100000
export SAVEHIST=120000
# Append command and time to $HISTFILE after executing it
setopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
# Use modern file-locking mechanisms, for better safety & performance.
setopt HIST_FCNTL_LOCK
# Keep only the most recent copy of each duplicate entry in history.
setopt HIST_IGNORE_ALL_DUPS
# Auto-sync history between concurrent sessions.
setopt SHARE_HISTORY

# Useful functions
source "$ZDOTDIR"/utils.zsh

source "$ZDOTDIR"/signal_handlers.zsh

# Add completion folder to fpath
[ -d "$ZDOTDIR"/completion ] && fpath+="$ZDOTDIR"/completion/

fpath+="$ZPLUGDIR"/zsh-completions/src

# source "${HOME}/.asdf/asdf.sh"
# [ -n "${ASDF_DIR}" ] && fpath=(${ASDF_DIR}/completions ${fpath})

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# Print unicode combined characters as a single glyph
setopt combiningchars

# completions
source "$ZDOTDIR"/completion.zsh

# Colors
autoload -Uz colors && colors

# Normal files to source
source "$ZDOTDIR"/aliases.zsh

[ -d "$ZDOTDIR"/conf.d ] && source "$ZDOTDIR"/conf.d/*

# FZF
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
# Using Ctrl+r so Alt is not needed
# bindkey -M emacs '^[r' fzf-history-widget
# bindkey -M vicmd '^[r' fzf-history-widget
# bindkey -M viins '^[r' fzf-history-widget

eval "$(zoxide init zsh)"
alias cd=z
# zle reset-prompt is needed to redisplay the shell prompt after executing the zi
# command.
run_zi() {
	zi
	zle reset-prompt
}
zle -N run_zi
bindkey -M vicmd "^[z" run_zi
bindkey -M viins "^[z" run_zi

go_fg() {
	fg
}
zle -N go_fg
bindkey "^f" go_fg

# Use starship for prompt https://github.com/starship/starship
eval "$(starship init zsh)"

#  PLUGINS
#
# This order is important!

source "$ZPLUGDIR"/zsh-bd/bd.zsh

# Backspace keybindings must go after loading zsh-autopair plugin. That's done
# in vim-mode plugin
source "$ZPLUGDIR"/zsh-autopair/autopair.zsh

# Must be loaded after zsh-autopair in order for some keybindings (backspace,
# etc.) to work.
source "$ZDOTDIR"/zsh-vim-mode-no-dep.zsh

source "$ZPLUGDIR"/zsh-autosuggestions/zsh-autosuggestions.zsh

source "$ZPLUGDIR"/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS+=brackets

# https://github.com/zsh-users/zsh-history-substring-search
source "$ZPLUGDIR"/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[k' history-substring-search-up
bindkey '^[j' history-substring-search-down
bindkey -M vicmd '^[k' history-substring-search-up
bindkey -M vicmd '^[j' history-substring-search-down
# Bind up and down arrow keys using portable ${terminfo[]} way
# up=kcuu1 down=kcud1 .
# ${terminfo[]} doesn't work on my Void system so using hardcoded values for
# up and down arrows
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd "^[[A" history-substring-search-up
bindkey -M vicmd "^[[B" history-substring-search-down

mode="$(darkman get)"
if [ "$mode" = "dark" ]; then
	export FZF_DEFAULT_OPTS="
	--color=bg+:#292e42,bg:#24283b,spinner:#bb9af7,hl:#565f89,fg:#c0caf5,header:#565f89,info:#7dcfff,pointer:#bb9af7,marker:#7dcfff,fg+:#ffffff,preview-bg:#24283b,prompt:#bb9af7,hl+:#bb9af7
	$FZF_DEFAULT_OPTS_NO_THEME"
else
	export FZF_DEFAULT_OPTS="
         --color fg:-1,bg:-1,hl:#268bd2,fg+:#073642,bg+:#eee8d5,hl+:#268bd2
         --color info:#b58900,prompt:#b58900,pointer:#002b36,marker:#002b36,spinner:#b58900
	 $FZF_DEFAULT_OPTS_NO_THEME"
fi
