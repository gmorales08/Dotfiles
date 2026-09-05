local M = {}

local function contains(values, wanted)
  for _, value in ipairs(values) do
    if value == wanted then
      return true
    end
  end

  return false
end

local function first_existing(stem, extensions)
  for _, extension in ipairs(extensions) do
    local path = string.format("%s.%s", stem, extension)
    if vim.uv.fs_stat(path) then
      return path
    end
  end

  -- Open a new buffer with the preferred extension when no counterpart exists.
  return string.format("%s.%s", stem, extensions[1])
end

function M.setup(opts)
  vim.keymap.set("n", "<Leader>vh", function()
    local filename = vim.api.nvim_buf_get_name(0)
    if filename == "" then
      vim.notify("Save the buffer before opening its source/header counterpart", vim.log.levels.WARN)
      return
    end

    local extension = vim.fn.fnamemodify(filename, ":e"):lower()
    local stem = vim.fn.fnamemodify(filename, ":r")
    local from_source = contains(opts.source_extensions, extension)
    local target_extensions = from_source and opts.header_extensions or opts.source_extensions
    local split_position = from_source and "rightbelow" or "leftabove"
    local target = first_existing(stem, target_extensions)

    vim.cmd(string.format("%s vsplit %s", split_position, vim.fn.fnameescape(target)))
  end, {
    buffer = true,
    silent = true,
    desc = "Open matching source/header in a vertical split",
  })
end

return M
