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
# man zshoptions
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
# Print unicode combined characters as a single glyph
setopt combiningchars
stty stop undef # Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')
unsetopt BEEP

autoload -Uz colors && colors

# Order is important
source "$MYRC_DIR"/funcs.sh

source "$ZDOTDIR"/plugins.zsh
source "$ZDOTDIR"/aliases.zsh
source "$ZDOTDIR"/utils.zsh
source "$ZDOTDIR"/signal_handlers.zsh

[ -d "$ZDOTDIR"/conf.d ] && source "$ZDOTDIR"/conf.d/*

# Add completion folder to fpath
[ -d "$ZDOTDIR"/completion ] && fpath+="$ZDOTDIR"/completion/
fpath+="$ZPLUGDIR"/zsh-completions/src
# completions
source "$ZDOTDIR"/completion.zsh

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

if [ "$(darkman get)" = "dark" ]; then
	export FZF_DEFAULT_OPTS="
	--color=bg+:#292e42,bg:#24283b,spinner:#bb9af7,hl:#565f89,fg:#c0caf5,header:#565f89,info:#7dcfff,pointer:#bb9af7,marker:#7dcfff,fg+:#ffffff,preview-bg:#24283b,prompt:#bb9af7,hl+:#bb9af7 $FZF_DEFAULT_OPTS_NO_THEME"
else
	export FZF_DEFAULT_OPTS="
         --color fg:-1,bg:-1,hl:#268bd2,fg+:#073642,bg+:#eee8d5,hl+:#268bd2
         --color info:#b58900,prompt:#b58900,pointer:#002b36,marker:#002b36,spinner:#b58900
	 $FZF_DEFAULT_OPTS_NO_THEME"
fi

eval "$(starship init zsh)"
