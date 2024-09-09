" Tab completion. Viene en la documentacion de github
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>

" Force refresh completion. De la documentacion
inoremap <C-@> <plug>(asyncomplete_force_refresh)
