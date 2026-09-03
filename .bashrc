# Configuracion para shell bash interactiva sin login

source ~/.bash/colors.bash # Importar primero para que prompt lea los colores
source ~/.bash/prompt.bash
source ~/.bash/env.bash
source ~/.bash/history.bash
source ~/.bash/path.bash
source ~/.bash/fzf.bash
source ~/.bash/aliases.bash
source ~/.bash/vendor/sdkman.bash

ulimit -c unlimited # Para poder generar core dumps

echo ".bashrc loaded"

export QSYS_ROOTDIR="/home/gabriel/altera_lite/25.1std/quartus/sopc_builder/bin"
