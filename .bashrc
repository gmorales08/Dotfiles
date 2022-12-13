##########################################
# Configuracion de bashrc por gmorales08 #
#                                        #
# Fecha de modificacion: 05/12/2022      #
##########################################

# COLORES

NOCOLOR="\033[0m"
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
LIGHT_GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
LIGHT_BLUE="\033[1;34m"
FUCHSIA="\033[0;35m"
LIGHT_FUCHSIA="\033[1;35m"
CYAN="\033[0;36m"
LIGHT_CYAN="\033[1;36m"
LIGHT_GRAY="\033[0;37m"
WHITE="\033[1;37m"


# PROMPT

source ~/.bash/.git-prompt.sh # Script para mostrar la rama git en el prompt
	                      # Obtenida de: https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

USUARIO="\u"
EQUIPO="\h"
DIRECTORIO="\w"
HORA_MINUTOS="\A"
NIVEL_ACCESO="\$"
GIT_BRANCH="$(__git_ps1 '(%s)')"

PROMPT_GABRIEL="${WHITE}[${HORA_MINUTOS}]${YELLOW}${USUARIO}~>${CYAN}${DIRECTORIO}${NIVEL_ACCESO}${GREEN}"

PROMPT_DIRTRIM=4 # Acorta el directorio en el prompt si pasa los 4 niveles de profundidad


export PS1="${PROMPT_GABRIEL}"


# COMANDOS QUE SE EJECUTAN AL INICIAR LA TERMINAL

neofetch


