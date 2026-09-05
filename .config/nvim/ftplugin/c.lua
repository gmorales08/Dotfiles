vim.treesitter.start()

local header_extensions = { "h" }

require("config.header_switch").setup({
  source_extensions = { "c" },
  header_extensions = header_extensions,
})

require("config.macros").setup({
  header_extensions = header_extensions,
})
