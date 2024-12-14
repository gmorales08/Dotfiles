# Importar el script para el prompt de git
source ~/.bash/.git-prompt.sh

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

