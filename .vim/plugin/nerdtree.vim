" Configuracion para NerdTree

" Atajo para abrir el fichero actual en NT
nmap <Leader>nt :NERDTreeFind<CR>
" Atajo para abrir NT en Vim sin ningun fichero en el buffer
nmap <Leader>nnt :NERDTree<CR>
" Para que cuando se abra un archivo desde el menu, se cierre NT
let NERDTreeQuitOnOpen=1
" Para ver dotfiles
let NERDTreeShowHidden=1
