"""""""""""""""""""""""""""""""""""""""""
" Configuracion de vimrc por gmorales08 "
"                                       "
" Version 2.0                           "
" Fecha de modificacion: 13/12/2022     "
"""""""""""""""""""""""""""""""""""""""""

" OPCIONES GENERALES DEL EDITOR

set nocompatible                 " Quita la compatibilidad con vi. No es necesario en versiones modernas de vim
set mouse=a                      " Para poder usar el raton en el editor

set noswapfile                   " No usa swapfiles
set undofile                     " Permite deshacer cambios aunque se cierre el editor
set undodir=~/.vim/undodir       " Directorio donde se guardan los .un

set encoding=UTF-8

if has("syntax")                 " Habilita resaltado de sintaxis en caso de estar disponible
  syntax on
endif

filetype indent on               " Permite identar segun la extension del archivo
filetype plugin on               " Carga el archivo ftplugin.vim que contiene configuracion para cada extension de fichero
                                 " Este archivo hay que crearlo, y puede ser un directorio donde se guarden ficheros del tipo lenguaje.vim para cada lenguaje

set number                       " Muestra el numero de linea
set relativenumber               " Numero de linea relativo.
set ruler                        " Muestra el numero de columna

set autoindent                   " Autoidentacion
set backspace=indent,eol,start   " Para que al pulsar retroceso vuelva a la linea anterior si es necesario

set splitright                   " Para que cuando se habra una ventana con vsplit se habra en la derecha
set fillchars+=vert:\┊           " Cambia el caracter que separa las ventanas
                                 " Otros caracteres: ┆ ┊ ∶ ⋮
"set laststatus=1                " Muestra siempre la satusbar. Activar en caso de no usar status bar personalizada
set showcmd                      " Muestra las teclas especiales pulsdas en la esquina inf. dcha.

set wildmenu                     " Cuando se escriben comandos en vim con :, se muestra un menu horizontal con las opciones disponibles
set wildmode=longest:full,full   " Formato de la lista de wildmenu
set hlsearch                     " Para que cuando se busque algo con / se marquen todas las ocurrencias

set t_Co=256                     " Permite que la terminal muestra 256 colores"

set list                         " Muestra tabuladores, fin de linea y espacios al final de la linea
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<


" STATUS BAR                     " Generada desde https://www.tdaly.co.uk/projects/vim-statusline-generator/

set laststatus=2                 " Necesario para mostrar la status bar personalizada
set statusline+=%1*              " Aplica la configuracion de color indicada abajo
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


" TAB BAR

" Funcion que genera una tabbar cuando se abren buffers en tabs.
" Solo muestra buffers activos
" Los titulos de los tabs muestran el nombre del fichero y un * si esta modificado
" Se puede pulsar sobre los tabs para acceder a ellos
set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
  let s = ''
  " loop through each tab page
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#' " WildMenu
    else
      let s .= '%#Title#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T '
    " set page number string
    let s .= i + 1 . ''
    " get buffer names and statuses
    let n = ''  " temp str for buf names
    let m = 0   " &modified counter
    let buflist = tabpagebuflist(i + 1)
    " loop through each buffer in a tab
    for b in buflist
      if getbufvar(b, "&buftype") == 'help'
        " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
      elseif getbufvar(b, "&buftype") == 'quickfix'
        " let n .= '[Q]'
      elseif getbufvar(b, "&modifiable")
        let n .= fnamemodify(bufname(b), ':t') . ', ' " pathshorten(bufname(b))
      endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    " let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')
    let n = substitute(n, ', $', '', '')
    " add modified label
    if m > 0
      let n .= '*'
      " let s .= '[' . m . '+]'
    endif
    if i + 1 == tabpagenr()
      let s .= ' %#TabLineSel#'
    else
      let s .= ' %#TabLine#'
    endif
    " add buffer names
    if n == ''
      let s.= '[New]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space
    let s .= ' '
  endfor
  let s .= '%#TabLineFill#%T'
  " right-aligned close button
  " if tabpagenr('$') > 1
  "   let s .= '%=%#TabLineFill#%999Xclose'
  " endif
  return s
endfunction


" ATAJOS PERSONALIZADOS

" :source map Para ver el origen de los atajos
let mapleader=" "                          " La tecla que inicia los atajos es el espacio

map <Leader>w :w<CR>                       " Guarda el archivo
map <C-s> :w<CR>
map <Leader>q :q<CR>                       " Cierra el archivo
imap <C-s> <Esc>:w<CR>                     " Guarda el archivo en modo Insert

map <Leader>h b                            " Para moverse mas rapido con Ctrl + hjkl
map <Leader>j ]m
map <Leader>k [m
map <Leader>l w


nmap <leader>1 :1tabnext<CR>               " Para moverse entre tabs cuando hay varios abiertos
nmap <leader>2 :2tabnext<CR>
nmap <leader>3 :3tabnext<CR>
nmap <leader>4 :4tabnext<CR>
nmap <leader>5 :5tabnext<CR>
nmap <leader>6 :6tabnext<CR>
nmap <leader>7 :7tabnext<CR>
nmap <leader>8 :8tabnext<CR>
nmap <leader>9 :9tabnext<CR>

nmap <leader>80 :set colorcolumn=80<CR>
				           " Atajos para abrir la terminal
nmap <Leader>t :!bash<CR>
nmap <Leader>vt :vertical terminal<CR>
nmap <Leader>bt :below terminal<CR>

tnoremap <Esc><Esc> <C-\><C-n>             " Si se abre una terminal en un split, para salir con Esc x2
tnoremap <C-h> <C-\><C-n>                  " Con Control h tambien se sale
tnoremap <Esc><Esc><Esc> <C-\><C-n>:q!<CR> " Para cerrar la terminal con Esc x3
					   " Los atajos para cada plugin estan en la configuracion correspondiente del plugin

" PLUGINS

" Gestor de plugins -> vim-plug
" Instalar desde https://github.com/junegunn/vim-plug
" Los plugins se pueden buscar en https://vimawesome.com/

" :PlugInstall para instalar un plugin
" :PlugUpdate  para actualizar un plugin
" :PlugClean   para desinstalar los plugins no utilizados

call plug#begin()

" Plugins para temas
Plug 'morhetz/gruvbox'                     " Gruvbox

" Plugins para directorios y archivos
Plug 'preservim/nerdtree'                  " Nerdtree. Explorador de archivos por terminal
Plug 'ryanoasis/vim-devicons'              " Iconos para vim. Necesita una fuente compatible
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                    " FuzzyFinder. Busqueda de archivos inteligente

" Plugins para el editor
Plug 'christoomey/vim-tmux-navigator'      " Permite navegar entre ventanas con la tecla ctrl + h/j/k/l

" Plugins para programacion
Plug 'valloric/youcompleteme'              " Autocompletado
Plug 'jiangmiao/auto-pairs'                " Autocompletado de llaves (, [, {, ", ', etc.
Plug 'tpope/vim-surround'                  " Para agregar llaves a una seleccion, p.e. rodear una palabra con "
Plug 'editorconfig/editorconfig-vim'       " Permite utilizar editorconfig
Plug 'sirver/ultisnips'                    " Permite crear macros para diferentes lenguajes y viene con algunas predefinidas
Plug 'honza/vim-snippets'                  " Necesario para ultisnips. Contiene los snippets predefinidos
Plug 'scrooloose/nerdcommenter'            " Para realizar comentarios de codigo con atajos"

call plug#end()


" TEMA DEL EDITOR

"colorscheme gruvbox
"colorscheme railscasts                    " Obtenido de https://github.com/jpo/vim-railscasts-theme. Instalado manualmente en.vim/colors/
                                           " Si el tema no carga al iniciar vim, crear un directorio .vim/after y mover .vim/colors alli
colorscheme gmorales                       " Tema personalizado hecho por mi. Esta ubicado en .vim/colors/gabriel.vim


" FILETYPE
"
" Para que los .h los lea con la sintaxis de C. Comentar para C++.
au BufRead,BufNewFile *.h set filetype=c
