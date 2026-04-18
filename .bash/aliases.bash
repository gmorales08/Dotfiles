alias dotfiles='cd /gmd/1LINUX/Dotfiles/'
alias programacion='cd /gmd/0PROGRAMACION/'
alias universidad='cd /gmd/0UNIVERSIDAD/'
alias vim=nvim

# Security
alias rm='f(){ for a in "$@"; do [ "$a" = "$HOME" ] || [ "$a" = "~" ] || [ "$a" = "/" ] && { echo "Be careful: rm $*"; return 1; }; done; command rm "$@"; }; f'
