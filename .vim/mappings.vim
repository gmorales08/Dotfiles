" ATAJOS PERSONALIZADOS

" :source map Para ver el origen de los atajos
" La tecla que inicia los atajos es el espacio
let mapleader=" "
" Guardar el archivo
map <Leader>w :w<CR>
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>
" Cerrar el archivo
map <Leader>q :q<CR>

" Para moverse entre llaves con Leader + hjkl
map <Leader>h b
map <Leader>j ]m
map <Leader>k [m
map <Leader>l w

" Para moverse entre tabs cuando hay varias abiertas
nmap <Leader>1 :1tabnext<CR>
nmap <Leader>2 :2tabnext<CR>
nmap <Leader>3 :3tabnext<CR>
nmap <Leader>4 :4tabnext<CR>
nmap <Leader>5 :5tabnext<CR>
nmap <Leader>6 :6tabnext<CR>
nmap <Leader>7 :7tabnext<CR>
nmap <Leader>8 :8tabnext<CR>
nmap <Leader>9 :9tabnext<CR>

" Resaltar la columna 80
nmap <Leader>80 :set colorcolumn=80<CR>

" Ir o volver de la definicion (requiere tags)
nmap <Leader>def <C-]>
nmap <Leader>fed <C-T>

" Cambiar de colorscheme
nmap <Leader>csd :set background=dark<CR>:colorscheme gmorales<CR>
nmap <Leader>csl :set background=light<CR>:colorscheme lunaperche<CR>

" Abrir la terminal
nmap <Leader>t :!bash<CR>
nmap <Leader>vt :vertical terminal<CR>
nmap <Leader>bt :below terminal<CR>

" Cerrar la terminal
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n>
tnoremap <Esc><Esc><Esc> <C-\><C-n>:q!<CR>

" Abrir el archivo en otro editor
nmap <Leader>vs :!code %<CR><CR>
nmap <Leader>ge :!gedit % &<CR><CR>

" Abrir o cerrar todos los folds
nmap <Leader>of zR
nmap <Leader>cf zM


" Atajos especificos para un tipo de archivo

" Abrir o crear un .h/.hpp asociado al .c/.cpp que estoy editando y viceversa
autocmd FileType c nmap <Leader>vh :exe (expand("%:e") == "c" ?
    \ "rightabove vsplit " . expand("%:r") . ".h" :
    \ "leftbelow vsplit " . expand("%:r") . ".c")<CR>

autocmd FileType cpp nmap <Leader>vh :exe (expand("%:e") == "cpp" ?
    \ "rigthbelow vsplit " . expand("%:r") . ".hpp" :
    \ "leftbelow vsplit " . expand("%:r") . ".cpp")<CR>


" Cargar la configuracion de un fichero vim
autocmd FileType vim nmap <Leader>% :source %<CR>


" DESACTIVACION DE ATAJOS PREDETERMINADOS

" Desactivar los atajos de las teclas H J K L
nnoremap H h
nnoremap J j
nnoremap K k
nnoremap L l
