# HUGE THANKS to https://github.com/Phantas0s !
# Check https://thevaluable.dev/zsh-install-configure-mouseless/ for
# explaination.


bindkey -v
export KEYTIMEOUT=1


source "${ZPLUGDIR}/cursor_mode.zsh"


autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd e edit-command-line
bindkey -M viins "^e" edit-command-line

# Add some of vim's text objects
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Mimic vim-surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
# Plain bindkey doesn't work with KEYTIMEOUT=1 because it executes vi 
# keybindins instead of waiting for the next key.
# An ugly hack below solves that problem.
# https://github.com/softmoth/zsh-vim-mode/issues/33
#
# bindkey -M vicmd cs change-surround
# bindkey -M vicmd ds delete-surround
# bindkey -M vicmd ys add-surround
# bindkey -M visual S add-surround
function change-hack() {
  read -k 1 option

  if [[ $option == 's' ]]; then
    zle -U Tcs
  elif [[ $option == 'c' ]]; then
    zle vi-change-whole-line
  else
    zle -U ${NUMERIC}Tvc$option
  fi
}

function delete-hack() {
  read -k 1 option

  if [[ $option == 's' ]]; then
    zle -U Tds
  elif [[ $option == 'd' ]]; then
    zle kill-whole-line
  else
    zle -U ${NUMERIC}Tvd$option
  fi
}

function yank-hack() {
  read -k 1 option

  if [[ $option == 's' ]]; then
    zle -U Tys
  elif [[ $option == 'y' ]]; then
    zle vi-yank-whole-line
  else
    zle -U ${NUMERIC}Tvy$option
  fi
}
zle -N change-hack
zle -N delete-hack
zle -N yank-hack
bindkey -M vicmd 'Tcs' change-surround
bindkey -M vicmd 'Tds' delete-surround
bindkey -M vicmd 'Tys' add-surround
bindkey -M vicmd 'Tvd' vi-delete
bindkey -M vicmd 'Tvc' vi-change
bindkey -M vicmd 'Tvy' vi-yank
bindkey -M vicmd 'c' change-hack
bindkey -M vicmd 'd' delete-hack
bindkey -M vicmd 'y' yank-hack
bindkey -M visual S add-surround

# bindkey without -M argument binds a key in main mode

zmodload zsh/complist
bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^K' vi-up-line-or-history
bindkey -M menuselect '^L' vi-forward-char
bindkey -M menuselect '^J' vi-down-line-or-history

# When in isearch mode, zsh looks for key bindins in isearch mode, and then if
# not found in main  mode, so you don't need to bind keys for isearch mode 
bindkey '^?' backward-delete-char # Delete one char with backspace
bindkey '^h' backward-delete-char

bindkey -M vicmd '?' vi-history-search-backward
bindkey -M vicmd '/' vi-history-search-forward

# Search through history for a string you've already typed up to the cursor and
# put cursor at the end
# Using https://github.com/zsh-users/zsh-history-substring-search instead
# autoload -U history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey "^[j" history-beginning-search-forward-end
# bindkey "^[k" history-beginning-search-backward-end
# bindkey -M vicmd "^[j" history-beginning-search-forward-end
# bindkey -M vicmd "^[k" history-beginning-search-backward-end

my-vim-backward-kill-word() {
	# vi-backward-delete-kill-word works only on inserted text
	# make backward-kill-word work like a vim one
	# https://www.reddit.com/r/zsh/comments/gp90cj/vimode_ctrlw_delete_only_text_inserted_in_current/
	local WORDCHARS="${WORDCHARS//[-\/]/}"
	zle backward-kill-word
}
zle -N my-vim-backward-kill-word
bindkey '^w' my-vim-backward-kill-word
# You can't delete a whole word in isearch mode
bindkey -M 'command' '^w' vi-backward-kill-word
# Use fzf's Ctrl-R binding
# bindkey '^r' history-incremental-search-backward
