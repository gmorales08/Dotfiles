"""""""""""""""""""""""""""""""""""""""""
" Configuracion de vimrc por gmorales08 "
"                                       "
" Version 2.0                           "
" Fecha de modificacion: 13/12/2022     "
"""""""""""""""""""""""""""""""""""""""""

" OPCIONES GENERALES DEL EDITOR

set nocompatible               " Quita la compatibilidad con vi. No es necesario en versiones modernas de vim 

set noswapfile                 " No usa swapfiles
set undofile                   " Permite deshacer cambios aunque se cierre el editor
set undodir=~/.vim/undodir     " Directorio donde se guardan los .un

set encoding=UTF-8

if has("syntax")               " Habilita resaltado de sintaxis en caso de estar disponible
  syntax on
endif

filetype indent on             " Permite identar segun la extension del archivo 
filetype plugin on             " Carga el archivo ftplugin.vim que contiene configuracion para cada extension de fichero
                               " Este archivo hay que crearlo, y puede ser un directorio donde se guarden ficheros del tipo lenguaje.vim para cada lenguaje

set number                     " Muestra el numero de linea
set relativenumber             " Numero de linea relativo
set ruler                      " Muestra el numero de columna

set autoindent                 " Autoidentacion
set backspace=indent,eol,start " Para que backspace funcione en insert mode

set fillchars+=vert:\┊         " Cambia el caracter que separa las ventanas
                               " Otros caracteres: ┆ ┊ ∶ ⋮  
"set laststatus=1              " Muestra siempre la satusbar. Activar en caso de no usar status bar personalizada
set showcmd                    " Muestra las teclas especiales pulsdas en la esquina inf. dcha.


" STATUS BAR                   " Generada desde https://www.tdaly.co.uk/projects/vim-statusline-generator/

set laststatus=2               " Necesario para mostrar la status bar personalizada 
set statusline+=%1*            " Aplica la configuracion de color indicada abajo
set statusline+=%F
set statusline+=%m
set statusline+=%=
set statusline+=%y
set statusline+=\ 
set statusline+=%l
set statusline+=:
set statusline+=%c
set statusline+=\ 
set statusline+=%P
hi User1 ctermbg=black ctermfg=yellow guibg=black guifg=yellow " Configuracion de color de la status bar


" ATAJOS PERSONALIZADOS

let mapleader=" "              " La tecla que inicia los atajos es el espacio

map <Leader>w :w<CR>           " Guarda el archivo
map <Leader>q :q<CR>           " Cierra el archivo
                               " Los atajos para cada plugin estan en la configuracion correspondiente del plugin









