" Configuracion para fzf

"esp + f + f (Busca un fichero por nombre)
map <Leader>ff :Files<CR>

"esp + f + l (Busca una palabra en el fichero actual)
map <Leader>fl :BLines<CR>
map <C-f> :BLines<CR>

" esp + f + a (Busca una palabra en todos los ficheros)
map <Leader>fa :Rg<CR>

" esp + tab (Busca en los tabs abiertos)
map <Leader><tab> :Windows<CR>

"Comando por defecto al usar :Files
"let $FZF_DEFAULT_COMMAND='rg --hidden -l ""'
"let $FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files'

":Rg no se puede configurar con una variable a dia de hoy, por eso tengo un
" .ripgreprc que tiene las opciones que quiero para :Rg
