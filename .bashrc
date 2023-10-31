##########################################
# Configuracion de bashrc por gmorales08 #
#                                        #
# Fecha de modificacion: 05/12/2022      #
##########################################

source ~/.bash/prompt.bash

# PERSONALIZACION DE COMANDOS

# En caso de que la terminal soporte colores para ls, los aplica
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi
