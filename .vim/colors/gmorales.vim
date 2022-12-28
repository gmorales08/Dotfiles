""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            GMORALES-COLORSCHEME                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A simply dark theme for vim terminal.
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


highlight Normal       ctermfg=255 ctermbg=234
highlight Visual                   ctermbg=242 term=reverse

highlight Cursor                   ctermbg=246
highlight CursorLine                           cterm=NONE
highlight LineNr       ctermfg=244             
highlight CursorLineNr ctermfg=249             cterm=NONE
highlight ColorColumn              ctermbg=235
highlight VertSplit    ctermfg=234 ctermbg=244
highlight SignColumn   ctermfg=244 ctermbg=234
highlight User1        ctermfg=252 ctermbg=234

highlight MatchParen               ctermbg=246

highlight NonText      ctermfg=240 

highlight Directory    ctermfg=153

highlight PMenu        ctermfg=254 ctermbg=238
highlight PmenuSel     ctermfg=255 ctermbg=244

highlight TabLine      ctermfg=252 ctermbg=237 
highlight TabLineSel   ctermfg=255 ctermbg=234
highlight TabLineFill  ctermfg=234 
highlight Title        ctermfg=252 ctermbg=237

highlight Comment      ctermfg=137 

highlight String       ctermfg=113
highlight Char         ctermfg=107
highlight Number       ctermfg=172
highlight Boolean      ctermfg=105
highlight Float        ctermfg=172

highlight Identifier   ctermfg=167 

highlight Statement    ctermfg=220

highlight PreProc      ctermfg=208

highlight Type         ctermfg=147
highlight StorageClass ctermfg=105

highlight Special      ctermfg=28

highlight Error        ctermfg=160 ctermbg=NONE
highlight SpellBad     ctermfg=160 ctermbg=NONE cterm=underline

highlight Todo         ctermfg=221 ctermbg=NONE cterm=bold

