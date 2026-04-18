-- LSP
vim.lsp.enable('clangd')
-- Treesitter
vim.treesitter.start()
-- Folds
-- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.wo[0][0].foldmethod = 'expr'
-- Indentation
-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
