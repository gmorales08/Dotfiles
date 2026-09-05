local M = {}

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.WARN, { title = "xxd" })
end

local function xxd_is_available()
  if vim.fn.executable("xxd") == 1 then
    return true
  end

  notify("xxd is not available in PATH", vim.log.levels.ERROR)
  return false
end

local function buffer_contents(bufnr)
  local separators = {
    dos = "\r\n",
    mac = "\r",
    unix = "\n",
  }
  local separator = separators[vim.bo[bufnr].fileformat] or "\n"
  local contents = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), separator)

  if vim.bo[bufnr].endofline then
    contents = contents .. separator
  end

  return contents
end

local function run_xxd(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local stat = filename ~= "" and vim.uv.fs_stat(filename) or nil
  local command = { "xxd" }
  local options = { text = true }

  -- Read an unmodified file directly so the view shows its exact on-disk bytes.
  if not vim.bo[bufnr].modified and stat and stat.type == "file" then
    command[#command + 1] = filename
  else
    -- Unsaved buffers are represented using their current line-ending style.
    options.stdin = buffer_contents(bufnr)
  end

  return vim.system(command, options):wait()
end

local function close_view(hex_bufnr, source_bufnr, source_view)
  local ok, err

  if vim.api.nvim_buf_is_valid(source_bufnr) then
    ok, err = pcall(vim.api.nvim_win_set_buf, 0, source_bufnr)
  else
    ok, err = pcall(vim.cmd, "enew")
  end

  if not ok then
    notify("Unable to return to the source buffer: " .. tostring(err), vim.log.levels.ERROR)
    return false
  end

  vim.fn.winrestview(source_view)

  if vim.api.nvim_buf_is_valid(hex_bufnr) then
    vim.api.nvim_buf_delete(hex_bufnr, { force = true })
  end

  return true
end

function M.open()
  local source_bufnr = vim.api.nvim_get_current_buf()

  if not xxd_is_available() then
    return false
  end

  if vim.bo[source_bufnr].buftype ~= "" then
    notify("This buffer type cannot be displayed with xxd", vim.log.levels.ERROR)
    return false
  end

  local run_ok, result = pcall(run_xxd, source_bufnr)
  if not run_ok then
    notify("Unable to run xxd: " .. tostring(result), vim.log.levels.ERROR)
    return false
  end

  if result.code ~= 0 then
    local reason = vim.trim(result.stderr or "")
    notify(reason ~= "" and reason or "xxd failed", vim.log.levels.ERROR)
    return false
  end

  local source_view = vim.fn.winsaveview()
  local source_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(source_bufnr), ":t")
  if source_name == "" then
    source_name = "[No Name]"
  end

  local hex_bufnr = vim.api.nvim_create_buf(false, true)
  local output = vim.split(result.stdout or "", "\n", { plain = true, trimempty = true })
  vim.api.nvim_buf_set_lines(hex_bufnr, 0, -1, false, output)
  vim.api.nvim_buf_set_name(hex_bufnr, string.format("xxd://%d/%s", hex_bufnr, source_name))

  vim.bo[hex_bufnr].bufhidden = "wipe"
  vim.bo[hex_bufnr].filetype = "xxd"
  vim.bo[hex_bufnr].modified = false
  vim.bo[hex_bufnr].modifiable = false
  vim.bo[hex_bufnr].readonly = true
  vim.bo[hex_bufnr].swapfile = false

  vim.keymap.set("n", "<Leader>xeh", function()
    close_view(hex_bufnr, source_bufnr, source_view)
  end, {
    buffer = hex_bufnr,
    desc = "Return from hexadecimal view",
  })

  local switch_ok, switch_error = pcall(vim.cmd, "hide buffer " .. hex_bufnr)
  if not switch_ok then
    vim.api.nvim_buf_delete(hex_bufnr, { force = true })
    notify("Unable to open the hexadecimal view: " .. tostring(switch_error), vim.log.levels.ERROR)
    return false
  end

  return true
end

function M.setup()
  vim.keymap.set("n", "<Leader>hex", M.open, {
    desc = "Show hexadecimal view",
  })
end

return M
