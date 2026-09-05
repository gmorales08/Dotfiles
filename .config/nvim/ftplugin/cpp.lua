vim.treesitter.start()

local header_extensions = require("config.filetypes").cpp_header_extensions()

require("config.header_switch").setup({
  source_extensions = { "cpp", "cc", "cxx" },
  header_extensions = header_extensions,
})

require("config.macros").setup({
  header_extensions = header_extensions,
})
