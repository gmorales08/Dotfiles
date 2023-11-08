#!/bin/bash

target_dir=prueba
dotfiles_dir=$(pwd)

DOTFILES=(
  .bashrc
  .editorconfig
  .gdbinit
  .gitconfig
  .vimrc
)

DOTDIRS=(
  .bash
  .config
  .vim
)

echo "====INSTALACION DE DOTFILES===="
echo "Se creara un enlace simbolico en el directorio $target_dir de:"
echo "Dotfiles:"
for file in "${DOTFILES[@]}"; do
  echo "  $file"
done
echo "Directorios:"
for dir in "${DOTDIRS[@]}"; do
  echo "  $dir"
done

echo "Continuar? (y/n): "
read continuar
if [ "$continuar" == "y" ] || [ "$continuar" == "Y" ]; then
  clear
else
  echo "Instalacion cancelada"
  exit
fi

# Enlace a ficheros
errores=""
echo "Instalando ficheros:"
for file in "${DOTFILES[@]}"; do
  msg="Creando enlace a $file..."
  comando="ln -s $dotfiles_dir/$file $target_dir"
  error=$(eval "$comando" 2>&1)
  if [ $? -eq 0 ]; then
    msg="$msg[OK]"
  else
    msg="$msg[ERROR]"
    errores="$errores$error\n"
  fi
  echo $msg
done
if [ -n "$errores" ]; then
  echo "Se produjeron los siguientes errores:"
  echo -e $errores
fi
# Enlace a directorios
errores=""
echo "Instalando directorios"
for dir in "${DOTDIRS[@]}"; do
  msg="Creando enlace a $dir..."
  comando="ln -s $dotfiles_dir/$dir $target_dir"
  error=$(eval "$comando" 2>&1)
  if [ $? -eq 0 ]; then
    msg="$msg[OK]"
  else
    msg="$msg[ERROR]"
    errores="$errores$error\n"
  fi
  echo $msg
done
if [ -n "$errores" ]; then
  echo "Se produjeron los siguientes errores:"
  echo -e $errores
fi

