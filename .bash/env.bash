# Variables de entorno de POSIX

# Editor no interactivo (ej. git commit)
export EDITOR="vim"

# Locales. LC_ALL sobrescribe LANG y todas las variables LC_* no definidas
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PAGER="less"
export SHELL="/bin/bash"
export TERM="alacritty"
# Editor interactivo o grafico
export VISUAL="vim"

# Variables de entorno XDG
# Algunas aplicaciones como MAME requieren que estas variables esten definidas
# explicitamente, aunque deberian estar configuradas automaticamente
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Ubicacion del fichero de configuracion de rg
# Requerido por el programa para ubicarlo
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"


# Opciones de la VM de Java. Se pueden comprobar con $ java -version, y deberia
# mostrar algo como Picked up _JAVA_OPTIONS: ...
# uiScale para escalar las ventanas a x2
export _JAVA_OPTIONS="-Dsun.java2d.uiScale=2.0"
export JDK_JAVA_OPTIONS="$_JAVA_OPTIONS"
export JAVA_TOOL_OPTIONS="$_JAVA_OPTIONS"

export XCURSOR_THEME=Papirus

# Variables de entorno personales
# Pongo nombres en espanol para evitar conflictos
# con variables del sistema

export EDITOR_TEXTO="mousepad"
export GESTOR_ARCHIVOS="nemo"

#echo ".bash/env.bash loaded"
