" Poner a 0 si uso diagnostics con ALE
let g:lsp_diagnostics_enabled = 1
let g:lsp_text_edit_enabled = 1


" Para invocar la funcion Hover o Ayuda de parametros con Ctrl+Space
nnoremap <C-@> :LspHover<CR>
inoremap <C-t> <Esc>l:LspSignatureHelp<CR>i


" No iniciar automaticamente los LSP
"let g:lsp_auto_enable = 0
let g:lsp_auto_enable = 1


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

