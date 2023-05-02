""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            GMORALES-COLORSCHEME                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A simply dark theme for vim terminal and gvim.
" It is designed for use in dark and bright enviroments, and for read it
" clearly and not tire your eyes
" 
" The codes for the colors are in https://www.ditig.com/256-colors-cheat-sheet

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="gmorales"


highlight Normal       ctermfg=255 ctermbg=234                   guifg=#eeeeee guibg=#1c1c1c
highlight Visual                   ctermbg=242  term=reverse                   guibg=#6c6c6c gui=reverse

highlight Cursor                   ctermbg=246                                 guibg=#949494
highlight CursorLine                            cterm=NONE                                   gui=NONE
highlight LineNr       ctermfg=244                               guifg=#808080
highlight CursorLineNr ctermfg=249              cterm=NONE       guifg=#b2b2b2               gui=NONE
highlight ColorColumn              ctermbg=235                                 guibg=#262626
highlight VertSplit    ctermfg=234 ctermbg=244                   guifg=#1c1c1c guibg=#808080
highlight SignColumn   ctermfg=244 ctermbg=234                   guifg=#808080 guibg=#1c1c1c
highlight User1        ctermfg=252 ctermbg=234                   guifg=#d0d0d0 guibg=#1c1c1c

highlight MatchParen               ctermbg=246                                 guibg=#949494

highlight NonText      ctermfg=240                               guifg=#585858

highlight Directory    ctermfg=153                               guifg=#afd7ff

highlight PMenu        ctermfg=254 ctermbg=238                   guifg=#e4e4e4 guibg=#444444
highlight PmenuSel     ctermfg=255 ctermbg=244                   guifg=#eeeeee guibg=#808080

highlight TabLine      ctermfg=252 ctermbg=237                   guifg=#d0d0d0 guibg=#3a3a3a
highlight TabLineSel   ctermfg=255 ctermbg=234                   guifg=#eeeeee guibg=#1c1c1c
highlight TabLineFill  ctermfg=234                               guifg=#1c1c1c 
highlight Title        ctermfg=252 ctermbg=237                   guifg=#d0d0d0 guibg=#3a3a3a

highlight Comment      ctermfg=137                               guifg=#af875f

highlight String       ctermfg=113                               guifg=#87d75f
highlight Char         ctermfg=107                               guifg=#87af5f
highlight Number       ctermfg=172                               guifg=#d78700
highlight Boolean      ctermfg=105                               guifg=#8787ff
highlight Float        ctermfg=172                               guifg=#d78700

highlight Identifier   ctermfg=167                               guifg=#d75f5f

highlight Statement    ctermfg=220                               guifg=#ffd700               gui=NONE

highlight PreProc      ctermfg=208                               guifg=#ff8700

highlight Type         ctermfg=147                               guifg=#afafff               gui=NONE
highlight StorageClass ctermfg=105                               guifg=#8787ff

highlight Special      ctermfg=28                                guifg=#008700

highlight Error        ctermfg=160 ctermbg=NONE                  guifg=#d70000 guibg=NONE
highlight SpellBad     ctermfg=160 ctermbg=NONE cterm=underline  guifg=#d70000 guibg=NONE    gui=underline

highlight Todo         ctermfg=221 ctermbg=NONE cterm=bold       guifg=#ffd75f guibg=NONE    gui=bold

