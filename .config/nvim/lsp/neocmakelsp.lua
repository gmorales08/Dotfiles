return {
  cmd = { "neocmakelsp", "stdio" },
  filetypes = { "cmake" },
  -- Also support standalone CMake files when no project marker is found.
  workspace_required = false,

  -- Ordered from the most specific NeoCMake configuration to broader
  -- project markers. CMakeLists.txt is deliberately omitted because nested
  -- projects commonly contain many of them and could create roots too deep.
  root_markers = {
    { ".neocmake.toml", ".neocmakelint.toml" },
    ".git",
    { "build", "cmake" },
  },

  -- NeoCMakeLSP only emits snippet placeholders when both this capability
  -- and init_options.use_snippets are enabled. Other LSPs keep snippets off.
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  },

  init_options = {
    -- Use NeoCMakeLSP's lightweight built-in formatter. It follows Neovim's
    -- effective indentation settings, which are populated by .editorconfig.
    format = {
      enable = true,
    },
    lint = {
      enable = true,
    },
    -- Scan CMake files shipped by installed packages for richer navigation
    -- and completion. Set to false if large package trees ever feel slow.
    scan_cmake_in_package = true,
    -- Treesitter already provides CMake highlighting.
    semantic_token = false,
    use_snippets = true,
  },
}
