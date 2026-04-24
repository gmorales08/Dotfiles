return {
  {
    'nvim-treesitter/nvim-treesitter',
	lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install { 'c', 'cpp', 'cmake', 'vim', 'vimdoc', 'lua' }
    end
  }
}
