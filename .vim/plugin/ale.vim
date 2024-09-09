let g:ale_linters = {
    \ 'asm': ['llvm_mc'],
    \ 'c': ['clangtidy', 'cppcheck'],
    \ 'cpp': ['clangtidy', 'cppcheck'],
    \ 'cuda': ['nvcc'],
    \ }

let g:ale_fixers = {
    \ 'c': ['clang'],
    \ 'cpp': ['clang'],
    \ }
let g:ale_asm_llvm_mc_executable = 'llvm-mc-14'
let g:ale_c_cc_options = '-std=c89 -Wall -pedantic'
let g:ale_cpp_cc_options = '-std=c++11 -Wall -pedantic'
let g:ale_cuda_nvcc_options = '-std=c++11 -Wall -pedantic'

let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
