function! GenerateHeader()
    let l:filename = expand('%:t:r')
    let l:extension = toupper(expand('%:e'))
    let l:guard = toupper(substitute(l:filename, '\([A-Z]\)', '_\1', 'g'))
    let l:guard = substitute(l:guard, '^_', '', '')
    let l:guard = l:guard . '_' . l:extension

    call setline('1', '#ifndef ' . l:guard)
    call setline('2', '#define ' . l:guard)
    call setline('3', '')
    call setline('4', '')
    call setline('5', '')
    call setline('6', '#endif /* ' . l:guard . ' */')

    execute 'normal! 3j'
endfunction

let @h = ":call GenerateHeader()\r"
