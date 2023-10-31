# Importar el script para el prompt de git
source ~/.bash/.git-prompt.sh # Script para mostrar la rama git en el prompt

# COLORES

# Identificados por los codigos ansi: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors

NOCOLOR="\033[0m"
BLACK="\033[30m"
RED="\033[91m"
GREEN="\033[92m"
YELLOW="\033[93m"
BLUE="\033[94m"
MAGENTA="\033[95m"
CYAN="\033[96m"
GRAY="\033[90m"
WHITE="\033[97m"


# PROMPT

USUARIO="\u"
EQUIPO="\h"
DIRECTORIO="\w"
HORA_MINUTOS="\A"
NIVEL_ACCESO="\$"
GIT_BRANCH="\$(__git_ps1)"
NUEVALINEA="\n"

PROMPT_GABRIEL="${GREEN}[${HORA_MINUTOS}]${YELLOW}${USUARIO}~>${CYAN}${DIRECTORIO}${NIVEL_ACCESO}${YELLOW}${GIT_BRANCH}${NUEVALINEA}${YELLOW}${NIVEL_ACCESO}$GREEN"

PROMPT_DIRTRIM=2 # Acorta el directorio en el prompt si pasa x niveles de profundidad


export PS1="${PROMPT_GABRIEL}"

