return {
  'nvim-treesitter/nvim-treesitter',
  branch = "master",
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "c", "cpp", "cmake", "bash"
      },
      highlight = {
  		enable = true,
  		additional_vim_regex_highlighting = false
  	  },
      indent = {
        enable = true
      },
    })
  end,
}
