-- Startup settings -----------------------------------------------------------

-- Disable netrw before loading plugins so it cannot race with nvim-tree when
-- opening directories.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leaders must be defined before lazy.nvim loads any plugin mappings.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set the filetype of .h files (C=true, C++=false). This must be chosen before registering
-- filetypes and enabling the language servers.
vim.g.use_h_as_c_header = true
require("config.filetypes").setup()

-- Editor behavior ------------------------------------------------------------

-- Enable the mouse in Normal, Visual and Insert modes only.
vim.opt.mouse = "nvi"

-- Keep swap files for crash recovery. Neovim 0.8+ stores them under
-- stdpath("state"), rather than beside the files being edited.
vim.opt.swapfile = true
-- Preserve undo history across sessions in the same state directory.
vim.opt.undofile = true

vim.opt.number = true
vim.opt.relativenumber = false
-- The custom statusline already shows the cursor position, so keeping the
-- built-in ruler enabled mostly affects whether CTRL-G repeats that position.
vim.opt.ruler = true

vim.opt.autoindent = true
-- Allow Backspace to cross indentation, line breaks and the insert start.
vim.opt.backspace = "indent,eol,start"

-- Indentation defaults used when a project has no .editorconfig.
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1 -- Use the current shiftwidth value.

-- Put new vertical splits on the right of the current window.
vim.opt.splitright = true
-- Draw a continuous line between vertical splits.
vim.opt.fillchars = "vert:│"

-- Show unfinished Normal-mode commands and Visual selection size.
vim.opt.showcmd = true
-- Make tabs, line endings and trailing spaces visible.
vim.opt.list = true
vim.opt.listchars = {
  tab = "-->",
  eol = "$",
  trail = "~",
}

vim.opt.colorcolumn = "80" -- Draw a guide; this does not enforce a line limit.

-- Wrap long lines at convenient boundaries while preserving visual indent.
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Reserve the diagnostics/sign column so text does not move when signs appear.
vim.opt.signcolumn = "yes"
-- Use a block cursor in all regular editing modes. Terminal-mode cursor color
-- and shape may still be controlled by the terminal emulator.
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"

-- These must be set before applying the color scheme.
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- External file changes ------------------------------------------------------

-- Reload externally changed files only when the buffer has no local changes.
vim.opt.autoread = true

local checktime_group = vim.api.nvim_create_augroup("ExternalFileChanges", { clear = true })

-- Check every loaded file after returning from another application.
vim.api.nvim_create_autocmd("FocusGained", {
  group = checktime_group,
  command = "checktime",
  desc = "Check loaded files for external changes",
})

-- On buffer changes, check only the regular file being entered.
vim.api.nvim_create_autocmd("BufEnter", {
  group = checktime_group,
  callback = function(event)
    local is_regular_file = vim.bo[event.buf].buftype == ""
      and vim.api.nvim_buf_get_name(event.buf) ~= ""

    if is_regular_file then
      vim.cmd(("checktime %d"):format(event.buf))
    end
  end,
  desc = "Check the entered file for external changes",
})

-- Components ----------------------------------------------------------------

-- Plugin loading must happen after the startup globals and editor options.
require("config.lazy")

-- Apply the scheme after lazy.nvim has placed plugin files on runtimepath.
vim.cmd("colorscheme gmorales_nvim")

-- UI modules run after the color scheme. The status bar also registers its
-- LSP event listeners before language servers are enabled.
require("config.status_bar").setup()
require("config.tabline").setup()

-- LSP configuration may use capabilities supplied by installed plugins.
require("config.lsp_client")

-- Load mappings last: leaders and any plugin APIs they use are now available.
require("config.mappings")

-- Append optional system-wide tags without replacing project-local tag paths.
local system_tags = vim.fn.expand("~/.vim/system.tags")
if vim.uv.fs_stat(system_tags) then
  vim.opt.tags:append(system_tags)
end
