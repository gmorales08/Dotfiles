-- Leader keys are configured once, near the start of init.lua.
--nmap → vim.keymap.set('n', ...)
--imap → vim.keymap.set('i', ...)
--map → vim.keymap.set('', ...)
--tnoremap → vim.keymap.set('t', ...)
--xnoremap → vim.keymap.set('x', ...)
--autocmd → vim.api.nvim_create_autocmd()
--Los mappings específicos de FileType usan { buffer = true } para que solo apliquen al buffer actual
-- Opciones comunes
local opts = { noremap = true, silent = false }

-- Guardar el fichero
vim.keymap.set('', '<Leader>w', ':w<CR>', opts)
vim.keymap.set('', '<C-s>', ':w<CR>', opts)
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', opts)

-- Cerrar el fichero
vim.keymap.set('', '<Leader>q', ':q<CR>', opts)

-- Moverse entre tabs
vim.keymap.set('n', '<Leader>1', ':1tabnext<CR>', opts)
vim.keymap.set('n', '<Leader>2', ':2tabnext<CR>', opts)
vim.keymap.set('n', '<Leader>3', ':3tabnext<CR>', opts)
vim.keymap.set('n', '<Leader>4', ':4tabnext<CR>', opts)
vim.keymap.set('n', '<Leader>5', ':5tabnext<CR>', opts)
vim.keymap.set('n', '<Leader>6', ':6tabnext<CR>', opts)
vim.keymap.set('n', '<Leader>7', ':7tabnext<CR>', opts)
vim.keymap.set('n', '<Leader>8', ':8tabnext<CR>', opts)
vim.keymap.set('n', '<Leader>9', ':9tabnext<CR>', opts)

-- Resaltar la columna 80
vim.keymap.set('n', '<Leader>80', ':set colorcolumn=80<CR>', opts)

-- Ir o volver de la definicion (requiere tags)
vim.keymap.set('n', '<Leader>def', '<C-]>', opts)
vim.keymap.set('n', '<Leader>fed', '<C-T>', opts)

-- Cambiar de colorscheme
vim.keymap.set('n', '<Leader>csd', ':set background=dark<CR>:colorscheme gmorales_nvim<CR>', opts)
vim.keymap.set('n', '<Leader>csl', ':set background=light<CR>:colorscheme lunaperche<CR>', opts)
vim.keymap.set('n', '<Leader>cs8', ':set background=dark<CR>:colorscheme gmorales8colors<CR>', opts)


-- Abrir en otro editor
vim.keymap.set('n', '<Leader>vs', ':!code %<CR><CR>', opts)
vim.keymap.set('n', '<Leader>ed', ':!$EDITOR_TEXTO %<CR><CR>', opts)
-- Abrir seleccion en otro editor
vim.keymap.set('x', '<Leader>ed', ':w !$EDITOR_TEXTO -<CR><CR>', opts)


-- Escribir el patron de substitucion de texto
vim.keymap.set('n', '<Leader>sub', ':%s/\\<antigua\\>/nueva/g"confirmacion:c', opts)

-- Open a read-only hexadecimal view without modifying the source buffer.
require("config.xxd").setup()


-- Comentar o descomentar un trozo de codigo (se hace de forma nativa desde nvim 0.10)
vim.keymap.set('n', '<Leader>cc', 'gcc', { remap = true })
vim.keymap.set('v', '<Leader>cc', 'gc', { remap = true })

-- Cambiar las teclas H J K L para que hagan los mismo que h j k l
vim.keymap.set('n', 'H', 'h', opts)
vim.keymap.set('n', 'J', 'j', opts)
vim.keymap.set('n', 'K', 'k', opts)
vim.keymap.set('n', 'L', 'l', opts)

-- Navegacion entre ventanas con Ctrl h j k l
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true, desc = 'Window left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true, desc = 'Window down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true, desc = 'Window up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true, desc = 'Window right' })
