# Historial de comandos bash en memoria en la sesion actual
export HISTSIZE=1000
# Historial de comandos bash en el fichero de historial
export HISTFILESIZE=5000
# Modificadores de control de historial de sesion (afecta a la sesion en
# memoria, no al .bash_history)
# ignoredups para no guardar duplicados
# erasedups para eliminar ocurrencias duplicadas guardando solo la ultima
export HISTCONTROL=ignoredups:erasedups
# Comandos que no se guardan en el historial
export HISTIGNORE="
ls:ls -la:ls -l:dir:\
fg:bg:\
bash:exit:clear:\
pwd:\
tmux"

# shopt habilita (-s) o deshabilita (-u) configuraciones opcionales de la shell
# histappend para concatenar en vez de sobreescribir el historial al cerrar
# una shell
shopt -s histappend
# cmdhist para que lineas multicomando se guarden como unica entrada en hist.
shopt -s cmdhist
