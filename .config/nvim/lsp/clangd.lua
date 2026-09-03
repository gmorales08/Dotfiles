return {
    cmd = {
    "clangd",
    "--all-scopes-completion",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--enable-config",
    "--pch-storage=memory",
    "--log=verbose",
    "--pretty"
    },
    filetypes = { 'c', 'cpp', 'cuda' },
	root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    -- 'compile_commands.json',
    -- 'compile_flags.txt',
    -- 'configure.ac',
    '.git',
  }
}
