OPT=/opt/bin
CUDA=/usr/local/cuda/bin
# Cargo guarda binarios por defecto en ~/.cargo/bin
CARGO_HOME=$HOME/.cargo/bin
# En ~/.local/bin se instalan algunos paquetes de pip
HOME_LOCAL_BIN=$HOME/.local/bin
#export PATH=$PATH:$CUDA:$OPT
export PATH=$CARGO_HOME:$HOME_LOCAL_BIN:$PATH

#echo ".bash/path.bash loaded"
