""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            GMORALES-COLORSCHEME                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=16
set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="gmorales8color"

"let b:blackTerm   = 0
"let b:redTerm     = 1
"let b:greenTerm   = 2
"let b:yellowTerm  = 3
"let b:blueTerm    = 4
"let b:magentaTerm = 5
"let b:cyanTerm    = 6
"let b:whiteTerm   = 7

"let b:blackGui   = '#000000'
"let b:redGui     = '#ff0000'
"let b:greenGui   = '#00ff00'
"let b:yellowGui  = '#ffff00'
"let b:blueGui    = '#0000ff'
"let b:magentaGui = '#ff00ff'
"let b:cyanGui    = '#00ffff'
"let b:whiteGui   = '#ffffff'

highlight ColorColumn       ctermfg=NONE  ctermbg=7     cterm=NONE 
highlight ColorColumn       guifg=NONE    guibg=#ffffff gui=NONE
"highlight Conceal          
highlight Cursor            ctermfg=NONE  ctermbg=2   cterm=reverse
highlight Cursor            guifg=NONE    guibg=#00ff00 gui=reverse
highlight lCursor           ctermfg=NONE  ctermbg=2    cterm=reverse
highlight lCursor           guifg=NONE    guibg=#00ff00 gui=reverse
highlight CursorIM          ctermfg=NONE  ctermbg=2    cterm=reverse
highlight CursorIM          guifg=NONE    guibg=#00ff00 gui=reverse
highlight CursorColumn      ctermfg=NONE  ctermbg=7     cterm=NONE
highlight CursorColumn      guifg=NONE    guibg=#ffffff gui=NONE
highlight CursorLine        ctermfg=NONE  ctermbg=7     cterm=NONE
highlight CursorLine        guifg=NONE    guibg=#ffffff gui=NONE
highlight Directory         ctermfg=6     ctermbg=NONE  cterm=NONE
highlight Directory         guifg=#00ffff guibg=NONE    gui=NONE
highlight DiffAdd           ctermfg=2     ctermbg=NONE  cterm=NONE
highlight DiffAdd           guifg=#00ff00 guibg=NONE    gui=NONE
highlight DiffChange        ctermfg=3     ctermbg=NONE  cterm=NONE
highlight DiffChange        guifg=#ffff00 guibg=NONE    gui=NONE
highlight DiffDelete        ctermfg=1     ctermbg=NONE  cterm=NONE
highlight DiffDelete        guifg=#ff0000 guibg=NONE    gui=NONE
highlight DiffText          ctermfg=6     ctermbg=NONE  cterm=NONE
highlight DiffText          guifg=#00ffff guibg=NONE    gui=NONE
highlight EndOfBuffer       ctermfg=6     ctermbg=NONE  cterm=NONE
highlight EndOfBuffer       guifg=#00ffff guibg=NONE    gui=NONE
highlight ErrorMsg          ctermfg=7    ctermbg=1     cterm=NONE
highlight ErrorMsg          guifg=#ffffff guibg=#ff0000 gui=NONE
highlight VertSplit         ctermfg=7    ctermbg=NONE  cterm=NONE
highlight VertSplit         guifg=#ffffff guibg=NONE    gui=NONE
highlight Folded            ctermfg=0    ctermbg=7     cterm=NONE
highlight Folded            guifg=#000000 guibg=#ffffff gui=NONE
highlight FoldColumn        ctermfg=6    ctermbg=NONE  cterm=NONE
highlight FoldColumnn       guifg=#00ffff guibg=NONE  cterm=NONE
highlight SignColumn        ctermfg=6    ctermbg=NONE  cterm=NONE
highlight SignColumn        guifg=#00ffff guibg=NONE  cterm=NONE
highlight IncSearch         ctermfg=NONE ctermbg=NONE cterm=reverse
highlight IncSearch         guifg=NONE  guibg=NONE gui=reverse
highlight LineNr            ctermfg=3    ctermbg=0 cterm=NONE
highlight LineNr            guifg=#ffff00  guibg=#000000 gui=NONE
highlight LineNrAbove       ctermfg=3    ctermbg=0 cterm=NONE
highlight LineNrAbove       guifg=#ffff00  guibg=#000000 gui=NONE
highlight LineNrBelow       ctermfg=3    ctermbg=0 cterm=NONE
highlight LineNrBelow       guifg=#ffff00  guibg=#000000 gui=NONE
highlight CursorLineNr      ctermfg=3    ctermbg=0 cterm=NONE
highlight CursorLineNr      guifg=#ffff00  guibg=#000000 gui=NONE
highlight CursorLineFold    ctermfg=0    ctermbg=2     cterm=NONE
highlight CursorLineFold    guifg=#000000 guibg=#00ff00 gui=NONE
highlight CursorLineSign    ctermfg=6    ctermbg=NONE  cterm=NONE
highlight CursorLineSign    guifg=#00ffff guibg=NONE  cterm=NONE
highlight MatchParen        ctermfg=NONE    ctermbg=NONE  cterm=reverse
highlight MatchParen        guifg=NONE guibg=NONE  cterm=reverse
"highlight MessageWindow 
highlight ModeMsg           ctermfg=7  ctermbg=0 cterm=NONE
highlight ModeMsg           guifg=#ffffff guibg=#000000 gui=NONE
highlight MsgArea           ctermfg=7  ctermbg=0 cterm=NONE
highlight MsgArea           guifg=#ffffff guibg=#000000 gui=NONE
highlight MoreMsg           ctermfg=7  ctermbg=0 cterm=NONE
highlight MoreMsg           guifg=#ffffff guibg=#000000 gui=NONE
highlight NonText           ctermfg=2 ctermbg=0 cterm=NONE
highlight NonText           guifg=#00ff00 guibg=#000000 gui=NONE
highlight Normal            ctermfg=7 ctermbg=0 cterm=NONE
highlight Normal            guifg=#ffffff guibg=#000000 gui=NONE
highlight Pmenu             ctermfg=0 ctermbg=7 cterm=NONE
highlight Pmenu             guifg=#000000 guibg=#ffffff gui=NONE
highlight PmenuSel          ctermfg=7 ctermbg=0 cterm=NONE
highlight PmenuSel          guifg=#ffffff guibg=#000000 gui=NONE
highlight PmenuKind         ctermfg=0 ctermbg=7 cterm=NONE
highlight PmenuKind         guifg=#000000 guibg=#ffffff gui=NONE
highlight PmenuKindSel      ctermfg=7 ctermbg=0 cterm=NONE
highlight PmenuKindSel      guifg=#ffffff guibg=#000000 gui=NONE
highlight PmenuExtra        ctermfg=0 ctermbg=7 cterm=NONE
highlight PmenuExtra        guifg=#000000 guibg=#ffffff gui=NONE
highlight PmenuExtraSel     ctermfg=7 ctermbg=0 cterm=NONE
highlight PmenuExtraSel     guifg=#ffffff guibg=#000000 gui=NONE
highlight PmenuThumb        ctermfg=0 ctermbg=7 cterm=NONE
highlight PmenuThumb        guifg=#000000 guibg=#ffffff gui=NONE
highlight PmenuMatch        ctermfg=0 ctermbg=7 cterm=NONE
highlight PmenuMatch        guifg=#000000 guibg=#ffffff gui=NONE
highlight PmenuMatchSel     ctermfg=7 ctermbg=0 cterm=NONE
highlight PmenuMatchSel     guifg=#ffffff guibg=#000000 gui=NONE
highlight PopupNotification ctermfg=0 ctermbg=7 cterm=NONE
highlight PopupNotification guifg=#000000 guibg=#ffffff gui=NONE
highlight Question          ctermfg=3 ctermbg=0 cterm=NONE
highlight Question          guifg=#ffff00 guibg=#000000 gui=NONE
highlight QuickFixLine      ctermfg=6 ctermbg=0 cterm=NONE
highlight QuickFixLine      guifg=#00ffff guibg=#000000 gui=NONE
highlight Search            ctermfg=0 ctermbg=7 cterm=NONE
highlight Search            guifg=#000000 guibg=#ffffff gui=NONE
highlight CurSearch         ctermfg=0 ctermbg=3 cterm=NONE
highlight CurSearch         guifg=#000000 guibg=#ffff00 gui=NONE
highlight SpecialKey        ctermfg=6 ctermbg=0 cterm=NONE
highlight SpecialKey        guifg=#00ffff guibg=#000000 gui=NONE
highlight SpellBad          ctermfg=0 ctermbg=1 cterm=NONE
highlight SpellBad          guifg=#000000 guibg=#ff0000 gui=NONE
"SpellCap
"SpellLocal
"SpellRare
highlight StatusLine        ctermfg=7 ctermbg=0 cterm=NONE
highlight StatusLine        guifg=#ffffff guibg=#000000 gui=NONE
highlight StatusLineNC      ctermfg=7 ctermbg=0 cterm=NONE
highlight StatusLineNC      guifg=#ffffff guibg=#000000 gui=NONE
highlight StatusLineTerm    ctermfg=7 ctermbg=0 cterm=NONE
highlight StatusLineTerm    guifg=#ffffff guibg=#000000 gui=NONE
highlight StatusLineTermNC  ctermfg=7 ctermbg=0 cterm=NONE
highlight StatusLineTermNC  guifg=#ffffff guibg=#000000 gui=NONE
highlight TabLine           ctermfg=0 ctermbg=7 cterm=NONE
highlight TabLine           guifg=#000000 guibg=#ffffff gui=NONE
highlight TabLineFill       ctermfg=0 ctermbg=7 cterm=NONE
highlight TabLineFill       guifg=#000000 guibg=#ffffff gui=NONE
highlight TabLineSel        ctermfg=7 ctermbg=0 cterm=NONE
highlight TabLineSel        guifg=#ffffff guibg=#000000 gui=NONE
"Terminal
highlight Title             ctermfg=0 ctermbg=7 cterm=NONE
highlight Title             guifg=#000000 guibg=#ffffff gui=NONE
highlight Visual            ctermfg=0 ctermbg=7 cterm=NONE
highlight Visual            guifg=#000000 guibg=#ffffff gui=NONE
highlight VisualNOS         ctermfg=0 ctermbg=7 cterm=NONE
highlight VisualNOS         guifg=#000000 guibg=#ffffff gui=NONE
highlight WarningMsg        ctermfg=1 ctermbg=0 cterm=NONE
highlight WarningMsg        guifg=#ff0000 guibg=#000000 gui=NONE
highlight WildMenu          ctermfg=0 ctermbg=7 cterm=NONE
highlight WildMenu          guifg=#000000 guibg=#ffffff gui=NONE


highlight Comment ctermfg=2 ctermbg=0 cterm=NONE
highlight Comment guifg=#00ff00 guibg=#000000 gui=NONE
highlight Constant ctermfg=5 ctermbg=0 cterm=NONE
highlight Constant guifg=#ff00ff guibg=#000000 gui=NONE
highlight Special ctermfg=3 ctermbg=0 cterm=NONE
highlight Special guifg=#ffff00 guibg=#000000 gui=NONE
highlight Identifier ctermfg=6 ctermbg=0 cterm=NONE
highlight Identifier guifg=#00ffff guibg=#000000 gui=NONE
highlight Statement ctermfg=6 ctermbg=0 cterm=NONE
highlight Statement guifg=#00ffff guibg=#000000 gui=NONE
highlight PreProc ctermfg=2 ctermbg=0 cterm=NONE
highlight PreProc guifg=#00ff00 guibg=#000000 gui=NONE
highlight Type ctermfg=3 ctermbg=0 cterm=NONE
highlight Type guifg=#ffff00 guibg=#000000 gui=NONE
highlight Underlined ctermfg=3 ctermbg=0 cterm=underline
highlight Underlined guifg=#ffff00 guibg=#000000 gui=underline
highlight Ignore ctermfg=0 ctermbg=NONE cterm=NONE
highlight Ignore guifg=#000000 guibg=NONE gui=NONE
highlight Added ctermfg=2 ctermbg=0 cterm=NONE
highlight Added guifg=#00ff00 guibg=#000000 gui=NONE
highlight Changed ctermfg=3 ctermbg=0 cterm=NONE
highlight Changed guifg=#ffff00 guibg=#000000 gui=NONE
highlight Removed ctermfg=1 ctermbg=0 cterm=NONE
highlight Removed guifg=#ff0000 guibg=#000000 gui=NONE
highlight Error ctermfg=0 ctermbg=1 cterm=NONE
highlight Error guifg=#000000 guibg=#ff0000 gui=NONE
highlight Todo ctermfg=0 ctermbg=3 cterm=NONE
highlight Todo guifg=#000000 guibg=#ffff00 gui=NONE














