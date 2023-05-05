# Zsh aliases

. "$MYRC_DIR/aliases" # Source my universal aliases

# If you want a command from an other shell instance first write local history
# to $HISTFILE from that shell, then read history from current shell.
# Writing first is not needed if INC_APPEND_HISTORY is set
alias shi="fc -AI" # Write current shell's history to $HISTFILE
alias rhi="fc -RI" # Read all history from $HISTFILE to current shell's
