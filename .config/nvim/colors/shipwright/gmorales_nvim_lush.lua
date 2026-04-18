--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym

local base00 = hsl("#1c1c1c")
local base01 = hsl("#262626")
local base02 = hsl("#3a3a3a")
local base03 = hsl("#585858")
local base04 = hsl("#b2b2b2")
--local base05 = hsl("#d0d0d0")
local base06 = hsl("#e4e4e4")
--local base07 = hsl("#eeeeee")
local base08 = hsl("#87d75f")
local base09 = hsl("#af875f")
local base0F = hsl("#d70000")
local base0A = hsl("#d75f00")
--local base0A = hsl("#d75f5f")
--local base0B = hsl("#d7875f")
--local base0C = hsl("#ff5f00")
local base0D = hsl("#ff8700")
--local base0E3 = hsl("#af875f")
--local base0E3 = hsl("#af5f00")
local base0E = hsl("#ffd700")
--local base0E4 = hsl("#d7af00")
--local base0E3 = hsl("#af8700")
local base0E3 = hsl("#d78700")
--local base0G = hsl("#afd7ff")
local base0G = hsl("#afd7d7")
--local base0H = hsl("#8787ff")
--local base0I = hsl("#5fd7ff")
local base0J = hsl("#00d700")
local base0L = hsl("#87af87")
--local base0L = hsl("#d7af00")
local baseXX = hsl("#ff0000")

  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
     ColorColumn    { bg = base01 }, -- Columns set with 'colorcolumn'
     Conceal        { fg = baseXX }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
     Cursor         { term = "reverse", gui = "reverse" }, -- Character under the cursor
     CurSearch      { fg = base01, bg = base0E, term = "bold", gui = "bold" }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    -- lCursor        { fg = baseXX, bg = baseXX }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM       { fg = baseXX, bg = baseXX }, -- Like Cursor, but used when in IME mode |CursorIM|
     CursorColumn   { fg = base06, bg = base02  }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
     CursorLine     { CursorColumn },
     Directory      { fg = base0E, bg = base00 }, -- Directory names (and other special names in listings)
    DiffAdd        { fg = base0J, term = "bold", gui = "bold" }, -- Diff mode: Added line |diff.txt|
    DiffChange     { fg = base0E, term = "bold", gui = "bold" }, -- Diff mode: Changed line |diff.txt|
    DiffDelete     { fg = base0F, term = "bold", gui = "bold" }, -- Diff mode: Deleted line |diff.txt|
    DiffText       { fg = base0J, term = "bold", gui = "bold" }, -- Diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer    { fg = base03 }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
     TermCursor     { Cursor },
     TermCursorNC   { Cursor },
     ErrorMsg       { fg = base0F, bg = base00, term = "bold", gui = "bold" }, -- Error messages on the command line
     VertSplit      { EndOfBuffer }, -- Column separating vertically split windows
     Folded         { bg = base02 }, -- Line used for closed folds
    -- FoldColumn     { fg = baseXX, bg = baseXX }, -- 'foldcolumn'
    SignColumn     { fg = base04 }, -- Column where |signs| are displayed
     IncSearch      { CurSearch }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
     Substitute     { fg = base01, bg = base09, term = "bold", gui = "bold" }, -- |:substitute| replacement text highlighting
    LineNr         { fg = base04 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    LineNrAbove    { fg = base03 }, -- Line number for when the 'relativenumber' option is set, above the cursor line
     LineNrBelow    { LineNrAbove }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr   { fg = base04 }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
     CursorLineFold { CursorLineNr }, -- Like FoldColumn when 'cursorline' is set for the cursor line
     CursorLineSign { CursorLineNr }, -- Like SignColumn when 'cursorline' is set for the cursor line
     MatchParen     { bg = base02 }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
     ModeMsg        { CursorLineNr }, -- 'showmode' message (e.g., "-- INSERT -- ")
     MsgArea        { ModeMsg }, -- Area for messages and cmdline
     MsgSeparator   { ModeMsg }, -- Separator for scrolled messages, `msgsep` flag of 'display'
     MoreMsg        { ModeMsg }, -- |more-prompt|
     NonText        { EndOfBuffer }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
     Normal         { fg = base06, bg = base00 }, -- Normal text
     NormalFloat    { fg = base06, bg = base01 }, -- Normal text in floating windows.
     FloatBorder    { NormalFloat }, -- Border of floating windows.
     FloatTitle     { NormalFloat, term = "bold", gui = "bold" }, -- Title of floating windows.
     NormalNC       { Normal }, -- normal text in non-current windows
     Pmenu          { fg = base06, bg = base02 }, -- Popup menu: Normal item.
     PmenuSel       { fg = base02, bg = base06 }, -- Popup menu: Selected item.
     PmenuKind      { Pmenu }, -- Popup menu: Normal item "kind"
     PmenuKindSel   { PmenuSel }, -- Popup menu: Selected item "kind"
     PmenuExtra     { Pmenu }, -- Popup menu: Normal item "extra text"
     PmenuExtraSel  { PmenuSel }, -- Popup menu: Selected item "extra text"
     PmenuSbar      { fg = base02, bg = base02 }, -- Popup menu: Scrollbar.
     PmenuThumb     { fg = base03, bg = base03 }, -- Popup menu: Thumb of the scrollbar.
     Question       { ModeMsg }, -- |hit-enter| prompt and yes/no questions
     QuickFixLine   { ModeMsg }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
     Search         { CurSearch }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
     SpecialKey     { EndOfBuffer }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
     SpellBad       { term = "undercurl", gui = "undercurl" }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
     SpellCap       { SpellBad }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
     SpellLocal     { SpellBad }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
     SpellRare      { SpellBad }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
     StatusLine     { fg = base04, bg = base00 }, -- Status line of current window
     StatusLineNC   { StatusLine }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
     TabLine        { fg = base04, bg = base01 }, -- Tab pages line, not active tab page label
     TabLineFill    { TabLine }, -- Tab pages line, where there are no labels
     TabLineSel     { Normal }, -- Tab pages line, active tab page label
     Title          { CursorLineNr }, -- Titles for output from ":set all", ":autocmd" etc.
     Visual         { bg = base02 }, -- Visual mode selection
     VisualNOS      { Visual }, -- Visual mode selection when vim is "Not Owning the Selection".
     WarningMsg     { fg = base0E, bg = base00, term = "bold", gui = "bold" }, -- Warning messages
     Whitespace     { EndOfBuffer }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
     Winseparator   { EndOfBuffer }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
     WildMenu       { PmenuSel }, -- Current match in 'wildmenu' completion
     WinBar         { TabLineSel }, -- Window bar of current window
     WinBarNC       { TabLineSel }, -- Window bar of not-current windows

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment        { fg = base09 }, -- Any comment

    Constant       { fg = base0A }, -- (*) Any constant
    String         { fg = base08 }, --   A string constant: "this is a string"
    Character      { fg = base0L }, --   A character constant: 'c', '\n'
    Number         { fg = base0G }, --   A number constant: 234, 0xff
     Boolean        { Number }, --   A boolean constant: TRUE, false
     Float          { Number }, --   A floating point constant: 2.3e10

    Identifier     { fg = base06 }, -- (*) Any variable name
    Function       { fg = base0D }, --   Function name (also: methods for classes)

    Statement      { fg = base0E }, -- (*) Any statement
    Conditional    { fg = base0A }, --   if, then, else, endif, switch, etc.
     Repeat         { Conditional }, --   for, do, while, etc.
     Label          { Conditional }, --   case, default, etc.
     Operator       { Identifier }, --   "sizeof", "+", "*", etc.
     Keyword        { Conditional }, --   any other keyword
     Exception      { Conditional }, --   try, catch, throw

     PreProc        { Character }, -- (*) Generic Preprocessor
     Include        { PreProc }, --   Preprocessor #include
     Define         { PreProc }, --   Preprocessor #define
     Macro          { PreProc }, --   Same as Define
     PreCondit      { PreProc }, --   Preprocessor #if, #else, #endif, etc.

    Type           { fg = base0E }, -- (*) int, long, char, etc.
    StorageClass   { fg = base0E3 }, --   static, register, volatile, etc.
     Structure      { StorageClass }, --   struct, union, enum, etc.
     Typedef        { StorageClass }, --   A typedef

     Special        { Type }, -- (*) Any special symbol
     SpecialChar    { Character }, --   Special character in a constant
     Tag            { PreProc }, --   You can use CTRL-] on this
     Delimiter      { Identifier }, --   Character that needs attention
     SpecialComment { Character }, --   Special things inside a comment (e.g. '\n')
     Debug          { fg = baseXX, bg = baseXX }, --   Debugging statements

     Underlined     { gui = "underline" }, -- Text that stands out, HTML links
     Ignore         { fg = baseXX, bg = baseXX }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error          { fg = base0F }, -- Any erroneous construct
    Todo           { fg = base0E, term = "bold", gui = "bold" }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
      LspSignatureActiveParameter { gui = "bold,underline", term = "bold,underline" } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
     DiagnosticError            { fg = base09, bg = base00 } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
     DiagnosticWarn             { DiagnosticError } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
     DiagnosticInfo             { DiagnosticWarn } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
     DiagnosticHint             { DiagnosticWarn } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
     DiagnosticOk               { fg = base0J, bg = base00, term = "bold", gui = "bold" } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
   -- DiagnosticUnderlineError   { DiagnosticError } , -- Used to underline "Error" diagnostics.
   -- DiagnosticUnderlineWarn    { DiagnosticWarn } , -- Used to underline "Warn" diagnostics.
   -- DiagnosticUnderlineInfo    { DiagnosticWarn } , -- Used to underline "Info" diagnostics.
   -- DiagnosticUnderlineHint    { DiagnosticWarn } , -- Used to underline "Hint" diagnostics.
   -- DiagnosticUnderlineOk      { DiagnosticOk } , -- Used to underline "Ok" diagnostics.
    DiagnosticFloatingError    { NormalFloat } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    DiagnosticFloatingWarn     { DiagnosticFloatingError } , -- Used to color "Warn" diagnostic messages in diagnostics float.
     DiagnosticFloatingInfo     { DiagnosticFloatingError } , -- Used to color "Info" diagnostic messages in diagnostics float.
     DiagnosticFloatingHint     { DiagnosticFloatingError } , -- Used to color "Hint" diagnostic messages in diagnostics float.
     DiagnosticFloatingOk       { DiagnosticFloatingError } , -- Used to color "Ok" diagnostic messages in diagnostics float.
     DiagnosticSignError        { LineNr }, --{ fg = base0F, bg = base00 } , -- Used for "Error" signs in sign column.
     DiagnosticSignWarn         { DiagnosticSignError }, --{ fg = base0E, bg = base00 } , -- Used for "Warn" signs in sign column.
     DiagnosticSignInfo         { DiagnosticSignWarn } , -- Used for "Info" signs in sign column.
     DiagnosticSignHint         { DiagnosticSignWarn } , -- Used for "Hint" signs in sign column.
     DiagnosticSignOk           { fg = base0J, bg = base00 } , -- Used for "Ok" signs in sign column.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

--     sym"@text.literal"      { fg = baseXX }, -- Comment
--     sym"@text.reference"    { fg = baseXX }, -- Identifier
--     sym"@text.title"        { fg = baseXX }, -- Title
    -- sym"@text.uri"          { fg = baseXX }, -- Underlined
    -- sym"@text.underline"    { fg = baseXX }, -- Underlined
    -- sym"@text.todo"         { fg = baseXX }, -- Todo
    -- sym"@comment"           { fg = baseXX }, -- Comment
    -- sym"@punctuation"       { fg = baseXX }, -- Delimiter
     sym"@constant"          { Constant }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
     sym"@constant.macro"    { PreProc }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
     sym"@number"            { Number }, -- Number
     sym"@boolean"           { Number }, -- Boolean
     sym"@float"             { Number }, -- Float
    -- sym"@function"          { }, -- Function
    sym"@function.builtin"  { Function }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    -- sym"@parameter"         { }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
     sym"@property"          { Identifier }, -- Identifier
     sym"@constructor"       { Function }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
     sym"@label"             { Label }, -- Label
    sym"@operator"          { Operator }, -- Operator
     sym"@keyword"           { Keyword }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    sym"@variable"          { Identifier }, -- Identifier
    sym"@type"              { Type }, -- Type
--   sym"@type.definition"   { fg = baseXX }, -- Typedef
--   sym"@storageclass"      { fg = baseXX }, -- StorageClass
--   sym"@structure"         { fg = baseXX }, -- Structure
    sym"@namespace"         { ErrorMsg }, -- Identifier
--   sym"@include"           { fg = baseXX }, -- Include
--   sym"@preproc"           { fg = baseXX }, -- PreProc
--   sym"@debug"             { fg = baseXX }, -- Debug
--   sym"@tag"               { fg = baseXX }, -- Tag
}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
