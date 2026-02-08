# COLORES

# Identificados por los codigos ansi:
# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors

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
    # Uso dircolors para aplicar colores automaticamente en base a los colores
    # de la terminal. Dejo los que aplica salvo DI (directorios, azul brillante)
    # y BD (block devices, amarillo brillante)
    # El comando dircolors exporta la variable LS_COLORS autoconfigurada
    eval $(dircolors)
    DI_VAL=$(dircolors | tr ':' '\n' | grep '^di=' | cut -d= -f2)
    BD_VAL=$(dircolors | tr ':' '\n' | grep '^bd=' | cut -d= -f2)
    export LS_COLORS=$(echo "$LS_COLORS" | sed -r \
        -e "s/(^|:)di=[^:]+/\1di=33/" \
        -e "s/(^|:)bd=[^:]+/\1bd=${DI_VAL}/")

    # ls --color=auto usa LS_COLORS si esta definida
    alias ls='ls --color=auto'
fi

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias tree='tree -C'

# En env.bash defino less como PAGER, por lo que otras aplicaciones que lo usen
# tambien tendran color, como git o man
export LESS='--RAW-CONTROL-CHARS'
# --use-color'
# Resaltado de sintaxis si esta disponible
if [ -x /usr/bin/source-highlight-esc.sh ]; then
    export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
fi


#echo ".bash/colors.bash loaded"
