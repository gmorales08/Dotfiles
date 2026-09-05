local format_filetypes = {
  c = true,
  cpp = true,
  sh = true,
  cmake = true,
}

return {
  "stevearc/conform.nvim",
  ft = { "c", "cpp", "sh", "cmake" },
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      c = { "clang-format", lsp_format = "fallback" },
      cpp = { "clang-format", lsp_format = "fallback" },
      sh = { "shfmt", lsp_format = "fallback" },
      -- CMake deliberately has no external formatter: lsp_format="fallback"
      -- delegates it to NeoCMakeLSP's lightweight built-in formatter.
      cmake = { lsp_format = "fallback" },
    },
    format_on_save = function(bufnr)
      if not format_filetypes[vim.bo[bufnr].filetype] then
        return
      end

      local conform = require("conform")
      local formatters, use_lsp = conform.list_formatters_to_run(bufnr)
      local formatter_names = {}
      for _, formatter in ipairs(formatters) do
        formatter_names[#formatter_names + 1] = formatter.name
      end

      local status_bar = require("config.status_bar")
      local generation = status_bar.format_started(bufnr, formatter_names, use_lsp)

      -- The callback runs after formatting, including the LSP fallback. A file
      -- that needed no edits still counts as a successful formatter run.
      return {
        timeout_ms = 2000,
      }, function(err)
        status_bar.format_finished(bufnr, generation, err == nil)
      end
    end,
    notify_on_error = true,
    notify_no_formatters = true,
  },
}
