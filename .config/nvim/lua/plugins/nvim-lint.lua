local function has_configured_linter(lint, filetype)
  if lint.linters_by_ft[filetype] then
    return true
  end

  for _, part in ipairs(vim.split(filetype, ".", { plain = true })) do
    if lint.linters_by_ft[part] then
      return true
    end
  end
  return false
end

local function tracked_try_lint(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
    return
  end

  vim.api.nvim_buf_call(bufnr, function()
    local lint = require("lint")
    if not has_configured_linter(lint, vim.bo[bufnr].filetype) then
      return
    end

    local status_bar = require("config.status_bar")
    local generation = status_bar.lint_started(bufnr)
    if not generation then
      return
    end

    lint.try_lint(nil, {
      wrap_linter = function(linter)
        local parser = linter.parser
        local parser_failed = false

        -- nvim-lint already accumulates function parser output. Doing it here
        -- lets us observe completion without parsing or storing the output twice.
        if type(parser) == "function" then
          local parse = parser
          parser = require("lint.parser").accumulate_chunks(function(...)
            local ok, diagnostics = pcall(parse, ...)
            if not ok then
              parser_failed = true
              error(diagnostics)
            end
            return diagnostics
          end)
        end

        local on_done = parser.on_done
        linter.parser = {
          on_chunk = parser.on_chunk,
          on_done = function(publish, parser_bufnr, cwd)
            local function tracked_publish(diagnostics)
              publish(diagnostics)
              if not parser_failed then
                -- Stream callbacks may run in a fast event; defer UI state safely.
                vim.schedule(function()
                  status_bar.linter_succeeded(bufnr, generation, linter.name)
                end)
              end
            end

            local ok, err = pcall(on_done, tracked_publish, parser_bufnr, cwd)
            if not ok then
              error(err)
            end
          end,
        }
        return linter
      end,
    })
  end)
end

return {
  "mfussenegger/nvim-lint",
  -- FileType fires before BufReadPost, so linting still runs on the initial read
  -- without loading this plugin for unrelated filetypes.
  ft = { "c", "cpp", "sh" },
  keys = {
    {
      "<leader>lin",
      function()
        tracked_try_lint()
      end,
      desc = "Trigger linting for current file",
    },
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

    -- Lint once after reading a file and after each save
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      group = lint_augroup,
      desc = "Lint current buffer",
      callback = function(ev)
        tracked_try_lint(ev.buf)
      end,
    })
  end,
}
