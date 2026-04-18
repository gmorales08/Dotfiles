" Las opciones de vim-lsp deben activarse antes de llamar a las funciones del
" plugin por eso las pongo al principio
" Poner a 0 si uso diagnostics con ALE
let g:lsp_diagnostics_enabled = 0
" Para permitir highlight del codigo con warning/error
let g:lsp_diagnostics_highlights_enabled = 1
" Para permitir signos (por ejemplo W> en la columna izquierda)
let g:lsp_diagnostics_signs_enabled = 1
" Para que muestre el warning como un hover
let g:lsp_diagnostics_float_cursor = 0
" Para que muestre el warning en el status bar
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_diagnostics_echo_delay = 200
" Para que muestre el warning junto al codigo
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_delay = 200
let g:lsp_diagnostics_virtual_text_align = "below"
let g:lsp_diagnostics_virtual_text_padding_left = 1
let g:lsp_diagnostics_virtual_text_prefix = " ! "
let g:lsp_diagnostics_virtual_text_wrap = "wrap"

" Los mensajes de warning y error en vim-lsp actualmente (2025) no se ven
" completos. (Por ejemplo clang-tidy solo te dice la descripcion del warning
" pero no el codigo ni el enlace a la documentacion). Para conseguir esto o se
" usa la funcion :LspDocumentDiagnostics o se usa ALE para que muestre el
" warning completo

"augroup LspFormatOnSave
    "autocmd!
    "" Ejecuta el formateo antes de escribir el búfer
    "autocmd BufWritePre * call s:LspFormat()
    "autocmd BufWritePost * call s:LspLint()
"augroup END

function! s:LspFormat() abort
    if exists(':LspDocumentFormatSync')
        silent! LspDocumentFormatSync
    endif
endfunction

function! s:LspLint() abort
    let g:lsp_diagnostics_enabled = 1
    if exists(':LspDocumentDiagnostics')
        " Ejecutamos el diagnóstico
        LspDocumentDiagnostics
        
        " Este 'redraw' es el que elimina el mensaje de 'Pulse INTRO' 
        " y limpia la barra inferior después de que el linter termine.
    endif
endfunction






" Para invocar la funcion Hover o Ayuda de parametros con Ctrl+Space
nnoremap <C-@> :LspHover<CR>
inoremap <C-t> <Esc>l:LspSignatureHelp<CR>i


" No iniciar automaticamente los LSP
"let g:lsp_auto_enable = 0
let g:lsp_auto_enable = 1


" Clangd, lsp de C y C++
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': [
        \   'clangd',
        \   '--all-scopes-completion',
        \   '--background-index',
        \   '--clang-tidy',
        \   '--completion-style=detailed',
        \   '--header-insertion=iwyu',
        \	'--header-insertion-decorators',
        \   '--enable-config',
        \   '--pch-storage=memory',
        \	'--log=verbose',
    	\ 	'--pretty'
        \ ],
        \ 'whitelist': ['c', 'cpp']
        \ })
endif


" neocmakelsp, lsp de cmake
if executable('neocmakelsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'neocmakelsp',
        \ 'cmd': {server_info -> ['neocmakelsp', 'stdio']},
        \ 'allowlist': ['cmake'],
        \ })
endif

" basedpyright-langserver, lsp de python
if executable('basedpyright-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'basedpyright-langserver',
        \ 'cmd': {server_info -> ['basedpyright-langserver', '--stdio']},
        \ 'allowlist': ['python'],
        \ })
endif

" hdl-checker, lsp de VHDL, Verilog y SystemVerilog
" utiliza varios linters. Instalar GHDL
"if executable('hdl_checker')
    "au User lsp_setup call lsp#register_server({
        "\ 'name': 'hdl_checker',
        "\ 'cmd': {server_info -> ['hdl_checker', '--lsp']},
        "\ 'allowlist': ['vhdl','verilog','systemverilog'],
        "\ })
"endif

" Configuracion ofrecida en la documentacion
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

