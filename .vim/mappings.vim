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

" Los atajos especificos para cada plugin estan en la configuracion
" correspondiente del plugin
