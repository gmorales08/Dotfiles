-- Needed for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Plugins
require("config.lazy")

-- LSP
require("config.lsp_client")

-- Vim config
vim.opt.mouse = "nvi"
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.ruler = true
vim.opt.autoindent = true
vim.opt.backspace="indent,eol,start"
vim.opt.expandtab = true
vim.opt.splitright = true
-- │ ┆ ┊ ∶ ⋮
vim.opt.fillchars = "vert:│"
vim.opt.showcmd = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "  ",
  --eol = "$",
  trail = "~",
}
vim.opt.tags = "~/.vim/system.tags"
vim.opt.autoread = true
vim.cmd("autocmd FocusGained,BufEnter * checktime")
vim.cmd("colorscheme gmorales_nvim")
--vim.cmd("autocmd BufRead,BufNewFile *.h set filetype=c")
vim.cmd("autocmd BufRead,BufNewFile *.v set filetype=verilog")
vim.cmd("autocmd BufRead,BufNewFile *.vh set filetype=verilog")
vim.opt.colorcolumn = "120"

-- New vim config
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"
vim.opt.pumheight = 20


-- Status bar
require('config.status_bar').setup()
-- Tab config
require('config.tabline').setup()
-- Mappings
require('config.mappings')
-- Macros
require('config.macros').setup()
