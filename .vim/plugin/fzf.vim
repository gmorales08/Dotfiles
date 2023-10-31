" Configuracion para fzf

"esp + f + f (Busca un fichero por nombre)
map <Leader>ff :Files<CR>

"esp + f + l (Busca una palabra en el fichero actual)
map <Leader>fl :BLines<CR>

" esp + f + l + l (Busca una palabra en todos los ficheros)
map <Leader>fll :Rg<CR>

"Para que incluya dotfiles en la busqueda
let $FZF_DEFAULT_COMMAND='rg --hidden -l ""'
