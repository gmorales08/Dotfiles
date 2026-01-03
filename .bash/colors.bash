# COLORES

# Identificados por los codigos ansi: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors

NOCOLOR="\[\e[0m\]"
BLACK="\[\e[30m\]"
RED="\[\e[91m\]"
GREEN="\[\e[92m\]"
YELLOW="\[\e[93m\]"
BLUE="\[\e[94m\]"
MAGENTA="\[\e[95m\]"
CYAN="\[\e[96m\]"
GRAY="\[\e[90m\]"
WHITE="\[\e[97m\]"

# COLORES DE COMANDOS
# En caso de que la terminal soporte colores para directorios, los aplica
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

#echo ".bash/colors.bash loaded"
