"""""""""""""""""""""""""""""""""""""""""
" Configuracion de vimrc por gmorales08 "
"""""""""""""""""""""""""""""""""""""""""

" OPCIONES GENERALES DEL EDITOR
" Quita la compatibilidad con vi. No es necesario en versiones modernas de vim
set nocompatible
" Para poder usar el raton en el editor
set mouse=a

" No usa swapfiles
set noswapfile
" Permite deshacer cambios aunque se cierre el editor
set undofile
" Directorio donde se guardan los .un
set undodir=~/.vim/undodir

" Codificacion
set encoding=UTF-8
" Habilitar resaltado de sintaxis en caso de estar disponible
if has("syntax")
  syntax on
endif

" Para identar segun la extension del archivo
filetype indent on
" Carga ftplugin.vim que contiene configuraciones para cada extension
" Este archivo hay que crearlo, y puede ser un directorio donde se guarden
" ficheros del tipo lenguaje.vim para cada lenguaje
filetype plugin on

" Muestra el numero de linea
set number
" Numero de linea relativo
set relativenumber
" Muestra el numero de columna
set ruler

" Autoindentacion
set autoindent
" Para que al pulsar retroceso vuelva a la linea anterior si es necesario
set backspace=indent,eol,start
" Expande el tabulador para que se muestre como espacios en vez de el caracter
" ascii. Para el tamano del tab uso .editorconfig
set expandtab

" Para que al abrir una ventana con vsplit se abra en la derecha
set splitright
" Cambia el caracter que separa las ventanas
" Otros caracteres: ┆ ┊ ∶ ⋮
set fillchars+=vert:\┊

" Muestra siempre la statusbar. Activar en caso de no usar statusbar
" personalizada
"set laststatus=1
" Muestra las teclas especiales pulsadas en la esquina inf. dcha.
set showcmd

" Autocompletado. Comentar si se usa plugin de autocompletado
"set omnifunc=syntaxcomplete#Complete
"set completeopt=longest,menuone

" Cuando se escriben comandos en vim con :, se muestra un menu horizontal con
" las opciones disponibles
set wildmenu
" Formato de la lista de wildmenu
set wildmode=longest:full,full
" Para que las opciones se muestren en vertical
set wildoptions=pum
" Para que al buscar con / se marquen todas las ocurrencias
set hlsearch

" Permite que la terminal muestre 256 colores
set t_Co=256

" Muestra caracteres especiales como caracteres
set list
set listchars=eol:$,trail:~
" tab:>-,extends:>,precedes:<

" Ubicacion de los tags. Generar previamente con ctags
set tags=./tags,~/.vim/system.tags

"TEMA DEL EDITOR
" Si el tema no carga al iniciar vim, crear un directorio .vim/after y mover .vim/colors alli
"colorscheme gruvbox
" Tema claro de vim
"colorscheme lunaperche
"Tema personalizado. Esta ubicado en .vim/colors/gmorales.vim
colorscheme gmorales


" FILETYPE
" Para que los .h los lea con la sintaxis de C.
au BufRead,BufNewFile *.h set filetype=c


" OTRAS CONFIGURACIONES
source ~/.vim/statusBar.vim
source ~/.vim/tabBar.vim
source ~/.vim/mappings.vim
source ~/.vim/macros.vim
source ~/.vim/plugins.vim
