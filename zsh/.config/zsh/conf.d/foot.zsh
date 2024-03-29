# vi: ft=zsh
#
autoload -Uz add-zsh-hook
# Scroll on CTRL-L in foot terminal 
if [[ $TERM =~ "^foot" ]]; then
    clear-screen-keep-sb() {
        # printf "\e[$((LINES - 1))S"
	i=$LINES
	until [ $i -le 1 ]; do
	    printf '\n'
	    i=$((i-1))
	done
        zle .clear-screen
    }
    zle -N clear-screen clear-screen-keep-sb
fi
function osc7 {
    local LC_ALL=C
    export LC_ALL

    setopt localoptions extendedglob
    input=( ${(s::)PWD} )
    uri=${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-\/])/%${(l:2::0:)$(([##16]#match))}}
    print -n "\e]7;file://${HOSTNAME}${uri}\e\\"
}
add-zsh-hook -Uz chpwd osc7

# Add hook for foot ctrl-shit-z/x key binding to work
precmd() {
	print -Pn "\e]133;A\e\\"
}
