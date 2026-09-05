-- C/C++ helpers invoked with @h and @i.
-- These are buffer-local mappings, not global macro registers.

local M = {}

local header_extensions = {
  h = true,
  hh = true,
  hpp = true,
  hxx = true,
}

local source_headers = {
  c = "h",
  cc = "hpp",
  cpp = "hpp",
  cxx = "hpp",
}

local function first_existing_header(source_filename, extensions)
  local stem = vim.fn.fnamemodify(source_filename, ":r")

  for _, extension in ipairs(extensions) do
    if vim.uv.fs_stat(stem .. "." .. extension) then
      return extension
    end
  end

  return extensions[1]
end

local function current_extension()
  return vim.fn.expand("%:e"):lower()
end

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.WARN, { title = "C/C++ helpers" })
end

local function buffer_is_empty()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  return #lines == 1 and lines[1] == ""
end

local function make_header_guard(filename, extension)
  local guard = filename
    :gsub("([A-Z]+)([A-Z][a-z])", "%1_%2")
    :gsub("([a-z0-9])([A-Z])", "%1_%2")

  guard = (guard .. "_" .. extension):upper()
  guard = guard:gsub("[^A-Z0-9_]", "_"):gsub("_+", "_")

  if guard:match("^%d") then
    guard = "HEADER_" .. guard
  end

  return guard
end

-- Generate an include guard in an empty header and enter Insert mode.
function M.generate_header()
  local extension = current_extension()
  if not header_extensions[extension] then
    notify("@h is only available in C/C++ header files")
    return false
  end

  if not vim.bo.modifiable then
    notify("The buffer is not modifiable", vim.log.levels.ERROR)
    return false
  end

  if not buffer_is_empty() then
    notify("@h only generates a template in an empty header")
    return false
  end

  local filename = vim.fn.expand("%:t:r")
  if filename == "" then
    notify("Save the header before generating its include guard")
    return false
  end

  local guard = make_header_guard(filename, extension)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "#ifndef " .. guard,
    "#define " .. guard,
    "",
    "",
    "",
    "#endif /* " .. guard .. " */",
  })

  vim.api.nvim_win_set_cursor(0, { 4, 0 })
  vim.cmd("startinsert")
  return true
end

-- Add the matching header at the beginning of a C/C++ source file.
function M.include_header(header_extensions_for_source)
  local extension = current_extension()
  local default_header_extension = source_headers[extension]
  if not default_header_extension then
    notify("@i is only available in C/C++ source files")
    return false
  end

  if not vim.bo.modifiable then
    notify("The buffer is not modifiable", vim.log.levels.ERROR)
    return false
  end

  local filename = vim.fn.expand("%:t:r")
  if filename == "" then
    notify("Save the source file before including its matching header")
    return false
  end

  local source_filename = vim.api.nvim_buf_get_name(0)
  local candidates = header_extensions_for_source
  if not candidates then
    candidates = extension == "c"
        and { default_header_extension }
        or require("config.filetypes").cpp_header_extensions()
  end
  local header_extension = first_existing_header(source_filename, candidates)
  local include_line = '#include "' .. filename .. "." .. header_extension .. '"'
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for _, line in ipairs(lines) do
    if vim.trim(line) == include_line then
      notify("The matching header is already included", vim.log.levels.INFO)
      return false
    end
  end

  if #lines == 1 and lines[1] == "" then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { include_line, "" })
  else
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { include_line, "" })
  end

  return true
end

function M.setup(opts)
  opts = opts or {}
  local extension = current_extension()

  if header_extensions[extension] then
    vim.keymap.set("n", "@h", M.generate_header, {
      buffer = true,
      desc = "Generate header guard",
    })
  elseif source_headers[extension] then
    vim.keymap.set("n", "@i", function()
      M.include_header(opts.header_extensions)
    end, {
      buffer = true,
      desc = "Include matching header",
    })
  end
end

return M
