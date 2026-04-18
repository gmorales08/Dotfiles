return {
  {
    'nvim-treesitter/nvim-treesitter',
	version = "v0.9.3",
	lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
            "c", "cpp", "lua", "vim", "vimdoc"
        },
        highlight = {
			enable = true,
			additional_vim_regex_highlighting = false
		},
        indent = {
            enable = true
        },
      })
    end
  }
}
