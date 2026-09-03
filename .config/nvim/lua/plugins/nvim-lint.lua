return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
        c = { "cppcheck" },
        cpp = { "cppcheck" },
        sh = { "shellcheck" },
    }

    -- Create an augroup to prevent duplicate autocmds
    local lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

    -- Lint when file opens and when e
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost"}, {
        group = lint_augroup,
        callback = function()
            lint.try_lint()
        end,
    })

    -- Map to lint manually
    vim.keymap.set("n", "<leader>lin", function()
        lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
