" Configuracion para fzf

map <Leader>ff :Files<CR>

"esp + f + l (Busca una palabra en el fichero actual)
map <Leader>fl :BLines<CR>

"Para que incluya dotfiles en la busqueda
let $FZF_DEFAULT_COMMAND='rg --hidden -l ""'
