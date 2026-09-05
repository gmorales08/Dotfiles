local M = {}

local api = vim.api
local uv = vim.uv

local formatting_method = "textDocument/formatting"
local highlight_group = "VisibleTabAndCR"
local highlight_match_var = "status_bar_tab_cr_match_id"
local highlight_toggle_var = "status_bar_highlight_tabs_and_cr"
local tab_cr_pattern = [[\t\|\%d13]]
-- Hide tool names below this terminal width, while keeping active indicators.
local full_tool_names_min_columns = 120

local tool_cache = {}
local tool_refresh_pending = {}
local eol_requests = {}
local git_cache = {}
local git_cache_generation = 0

local function is_regular_buffer(bufnr)
  return api.nvim_buf_is_valid(bufnr)
    and api.nvim_buf_is_loaded(bufnr)
    and vim.bo[bufnr].buftype == ""
    and vim.bo[bufnr].filetype ~= "NvimTree"
end

local function redraw_statusline()
  pcall(vim.cmd, "redrawstatus")
end

local function unique_sorted(values)
  local result = {}
  local seen = {}

  for _, value in ipairs(values) do
    if type(value) == "string" and value ~= "" and not seen[value] then
      seen[value] = true
      result[#result + 1] = value
    end
  end

  table.sort(result)
  return result
end

local function same_values(left, right)
  if left == right then
    return true
  end
  if type(left) ~= "table" or type(right) ~= "table" or #left ~= #right then
    return false
  end

  for index, value in ipairs(left) do
    if value ~= right[index] then
      return false
    end
  end
  return true
end

local function tool_state(bufnr)
  local cached = tool_cache[bufnr]
  if cached then
    return cached
  end

  cached = {
    diagnostics = "",
    formatters = {},
    linters = {},
    lsps = {},
    format_generation = 0,
    lint_generation = 0,
    pending_formatters = {},
  }
  tool_cache[bufnr] = cached
  return cached
end

local function set_tool_names(cached, key, names)
  names = unique_sorted(names or {})
  if same_values(cached[key], names) then
    return
  end

  cached[key] = names
  redraw_statusline()
end

local function lsp_client_names(bufnr, method)
  local names = {}
  local ok, clients = pcall(vim.lsp.get_clients, { bufnr = bufnr })
  if not ok then
    return names
  end

  for _, client in ipairs(clients) do
    local supports_method = true
    if method then
      local method_ok, supported = pcall(client.supports_method, client, method, bufnr)
      supports_method = method_ok and supported
    end

    if supports_method then
      names[#names + 1] = client.name
    end
  end

  return unique_sorted(names)
end

local function refresh_lsp(bufnr)
  if not is_regular_buffer(bufnr) then
    tool_cache[bufnr] = nil
    redraw_statusline()
    return
  end

  set_tool_names(tool_state(bufnr), "lsps", lsp_client_names(bufnr))
end

local function refresh_lsp_later(bufnr)
  if tool_refresh_pending[bufnr] then
    return
  end
  tool_refresh_pending[bufnr] = true

  vim.schedule(function()
    tool_refresh_pending[bufnr] = nil
    refresh_lsp(bufnr)
  end)
end

local function reset_execution_results(bufnr)
  if not is_regular_buffer(bufnr) then
    return
  end

  local cached = tool_state(bufnr)
  cached.lint_generation = cached.lint_generation + 1
  cached.format_generation = cached.format_generation + 1
  cached.pending_formatters = {}
  set_tool_names(cached, "linters", {})
  set_tool_names(cached, "formatters", {})
end

local function refresh_diagnostics(bufnr)
  if not is_regular_buffer(bufnr) then
    return
  end

  local counts = vim.diagnostic.count(bufnr)
  local errors = counts[vim.diagnostic.severity.ERROR] or 0
  local warnings = counts[vim.diagnostic.severity.WARN] or 0
  local parts = {}

  if errors > 0 then
    parts[#parts + 1] = "E" .. errors
  end
  if warnings > 0 then
    parts[#parts + 1] = "W" .. warnings
  end

  local cached = tool_state(bufnr)
  local diagnostics = table.concat(parts, " ")
  if cached.diagnostics ~= diagnostics then
    cached.diagnostics = diagnostics
    redraw_statusline()
  end
end

-- Linters are short-lived processes, so this stores the last successful run.
function M.lint_started(bufnr)
  if not is_regular_buffer(bufnr) then
    return nil
  end

  local cached = tool_state(bufnr)
  cached.lint_generation = cached.lint_generation + 1
  set_tool_names(cached, "linters", {})
  return cached.lint_generation
end

function M.linter_succeeded(bufnr, generation, name)
  if not is_regular_buffer(bufnr) then
    return
  end

  local cached = tool_state(bufnr)
  if generation ~= cached.lint_generation then
    return
  end

  local names = vim.list_slice(cached.linters)
  names[#names + 1] = name
  set_tool_names(cached, "linters", names)
end

-- Capture the exact formatters selected for this run, but do not display them
-- until Conform reports successful completion.
function M.format_started(bufnr, formatter_names, use_lsp)
  if not is_regular_buffer(bufnr) then
    return nil
  end

  local cached = tool_state(bufnr)
  cached.format_generation = cached.format_generation + 1

  local names = vim.list_slice(formatter_names or {})
  if use_lsp then
    vim.list_extend(names, lsp_client_names(bufnr, formatting_method))
  end
  cached.pending_formatters = unique_sorted(names)
  set_tool_names(cached, "formatters", {})
  return cached.format_generation
end

function M.format_finished(bufnr, generation, succeeded)
  if not is_regular_buffer(bufnr) then
    return
  end

  local cached = tool_state(bufnr)
  if generation ~= cached.format_generation then
    return
  end

  local names = succeeded and cached.pending_formatters or {}
  cached.pending_formatters = {}
  set_tool_names(cached, "formatters", names)
end

local function buffer_directory(bufnr)
  local filename = api.nvim_buf_get_name(bufnr)
  if filename == "" then
    return vim.fn.getcwd()
  end
  return vim.fn.fnamemodify(filename, ":p:h")
end

local function set_buffer_git_state(bufnr, directory, root, branch, generation)
  if not api.nvim_buf_is_valid(bufnr) then
    return false
  end

  local changed = vim.b[bufnr].statusline_git_branch ~= branch
  vim.b[bufnr].statusline_git_branch = branch
  vim.b[bufnr].statusline_git_directory = directory
  vim.b[bufnr].statusline_git_root = root or ""
  vim.b[bufnr].statusline_git_generation = generation
  return changed
end

local function finish_git_request(root, request, generation, branch)
  local cached = git_cache[root]
  if not cached or cached.request ~= request then
    return
  end

  local waiting = cached.waiting or {}
  cached.pending_generation = nil
  cached.waiting = {}
  if generation ~= git_cache_generation then
    return
  end

  cached.branch = branch
  cached.generation = generation

  local changed = false
  for bufnr, directory in pairs(waiting) do
    if api.nvim_buf_is_valid(bufnr) and vim.b[bufnr].statusline_git_root == root then
      changed = set_buffer_git_state(bufnr, directory, root, branch, generation) or changed
    end
  end
  if changed then
    redraw_statusline()
  end
end

local function update_git_branch(bufnr, recompute_root)
  if not is_regular_buffer(bufnr) then
    return
  end

  local directory = buffer_directory(bufnr)
  local directory_changed = vim.b[bufnr].statusline_git_directory ~= directory

  if not recompute_root
    and not directory_changed
    and vim.b[bufnr].statusline_git_generation == git_cache_generation
  then
    return
  end

  local root
  local cached_root = vim.b[bufnr].statusline_git_root
  if not recompute_root and not directory_changed and cached_root and cached_root ~= "" then
    root = cached_root
  else
    local source = api.nvim_buf_get_name(bufnr)
    source = source ~= "" and source or directory
    local ok, detected_root = pcall(vim.fs.root, source, ".git")
    root = ok and detected_root or nil
  end

  if not root then
    if set_buffer_git_state(bufnr, directory, nil, "", git_cache_generation) then
      redraw_statusline()
    end
    return
  end

  root = vim.fs.normalize(root)
  local cached = git_cache[root]
  if not cached then
    cached = {
      branch = "",
      generation = -1,
      request = 0,
      waiting = {},
    }
    git_cache[root] = cached
  end

  if cached.generation == git_cache_generation then
    if set_buffer_git_state(bufnr, directory, root, cached.branch, git_cache_generation) then
      redraw_statusline()
    end
    return
  end

  -- Share one asynchronous Git request among every buffer in this repository.
  if cached.pending_generation == git_cache_generation then
    cached.waiting[bufnr] = directory
    if set_buffer_git_state(bufnr, directory, root, cached.branch, git_cache_generation) then
      redraw_statusline()
    end
    return
  end

  cached.request = cached.request + 1
  cached.pending_generation = git_cache_generation
  cached.waiting = { [bufnr] = directory }
  local request = cached.request
  local generation = git_cache_generation
  if set_buffer_git_state(bufnr, directory, root, cached.branch, generation) then
    redraw_statusline()
  end

  if vim.fn.executable("git") ~= 1 then
    finish_git_request(root, request, generation, "")
    return
  end

  local ok = pcall(vim.system, {
    "git",
    "-C",
    root,
    "symbolic-ref",
    "--quiet",
    "--short",
    "HEAD",
  }, { text = true }, function(result)
    vim.schedule(function()
      local branch = result.code == 0 and vim.trim(result.stdout or "") or ""
      finish_git_request(root, request, generation, branch)
    end)
  end)

  if not ok then
    finish_git_request(root, request, generation, "")
  end
end

local function effective_eol(bufnr)
  return ({
    unix = "LF",
    dos = "CRLF",
    mac = "CR",
  })[vim.bo[bufnr].fileformat] or ""
end

local function store_disk_eol(bufnr, filename, request, label)
  vim.schedule(function()
    if eol_requests[bufnr] ~= request
      or not api.nvim_buf_is_valid(bufnr)
      or api.nvim_buf_get_name(bufnr) ~= filename
    then
      return
    end

    vim.b[bufnr].statusline_disk_eol = label
    redraw_statusline()
  end)
end

-- Read the file asynchronously so EditorConfig cannot hide its on-disk EOLs.
local function detect_disk_eol(bufnr)
  if not is_regular_buffer(bufnr) then
    return
  end

  local filename = api.nvim_buf_get_name(bufnr)
  if filename == "" then
    vim.b[bufnr].statusline_disk_eol = nil
    redraw_statusline()
    return
  end

  eol_requests[bufnr] = (eol_requests[bufnr] or 0) + 1
  local request = eol_requests[bufnr]
  vim.b[bufnr].statusline_disk_eol = nil

  uv.fs_open(filename, "r", 438, function(open_error, fd)
    if open_error or not fd then
      store_disk_eol(bufnr, filename, request, nil)
      return
    end
    if eol_requests[bufnr] ~= request then
      uv.fs_close(fd)
      return
    end

    local offset = 0
    local pending_cr = false
    local seen = { crlf = false, lf = false, cr = false }
    local finished = false

    local function label_from_seen()
      local count = (seen.crlf and 1 or 0) + (seen.lf and 1 or 0) + (seen.cr and 1 or 0)
      if count > 1 then
        return "MIXED"
      elseif seen.crlf then
        return "CRLF"
      elseif seen.lf then
        return "LF"
      elseif seen.cr then
        return "CR"
      end
      return nil
    end

    local function finish(label, store_result)
      if finished then
        return
      end
      finished = true
      uv.fs_close(fd)
      if store_result ~= false then
        store_disk_eol(bufnr, filename, request, label)
      end
    end

    local function mark(kind)
      seen[kind] = true
      return label_from_seen() == "MIXED"
    end

    local read_next
    read_next = function()
      uv.fs_read(fd, 65536, offset, function(read_error, data)
        -- A newer read/write request supersedes this scan.
        if eol_requests[bufnr] ~= request then
          finish(nil, false)
          return
        end
        if read_error then
          finish(nil)
          return
        end

        if not data or data == "" then
          if pending_cr then
            mark("cr")
          end
          finish(label_from_seen())
          return
        end

        offset = offset + #data
        local index = 1

        if pending_cr then
          pending_cr = false
          if data:byte(1) == 10 then
            if mark("crlf") then
              finish("MIXED")
              return
            end
            index = 2
          elseif mark("cr") then
            finish("MIXED")
            return
          end
        end

        -- Use C-backed string searches instead of visiting every byte in Lua.
        if data:find("\r\n", index, true) and mark("crlf") then
          finish("MIXED")
          return
        end
        if (data:byte(index) == 10 or data:find("[^\r]\n", index)) and mark("lf") then
          finish("MIXED")
          return
        end
        if data:find("\r[^\n]", index) and mark("cr") then
          finish("MIXED")
          return
        end

        pending_cr = data:byte(#data) == 13
        read_next()
      end)
    end

    read_next()
  end)
end

local function define_tab_cr_highlight()
  api.nvim_set_hl(0, highlight_group, {
    bg = "#ff0000",
    ctermbg = 9,
  })
end

local function remove_tab_cr_match(winid)
  if not api.nvim_win_is_valid(winid) then
    return
  end

  local id = vim.w[winid][highlight_match_var]
  if type(id) == "number" and id > 0 then
    pcall(vim.fn.matchdelete, id, winid)
  end
  vim.w[winid][highlight_match_var] = nil
end

local function sync_tab_cr_match(winid)
  if not api.nvim_win_is_valid(winid) then
    return
  end

  remove_tab_cr_match(winid)
  if vim.g[highlight_toggle_var] ~= true then
    return
  end

  local ok, id = pcall(vim.fn.matchadd, highlight_group, tab_cr_pattern, 100, -1, {
    window = winid,
  })
  if ok and id > 0 then
    vim.w[winid][highlight_match_var] = id
  end
end

local function sync_all_tab_cr_matches()
  for _, winid in ipairs(api.nvim_list_wins()) do
    sync_tab_cr_match(winid)
  end
  pcall(vim.cmd, "redraw")
end

local function toggle_tab_cr_highlight()
  vim.g[highlight_toggle_var] = vim.g[highlight_toggle_var] ~= true
  sync_all_tab_cr_matches()

  local state = vim.g[highlight_toggle_var] and "enabled" or "disabled"
  vim.notify("Tab and CR background highlighting " .. state, vim.log.levels.INFO, {
    title = "Whitespace",
  })
end

function _G.statusline_git_branch_segment()
  if not is_regular_buffer(api.nvim_get_current_buf()) then
    return ""
  end

  local branch = vim.b.statusline_git_branch or ""
  return branch ~= "" and "(" .. branch .. ")" or ""
end

function _G.statusline_diag_segment()
  local bufnr = api.nvim_get_current_buf()
  if not is_regular_buffer(bufnr) then
    return ""
  end

  local cached = tool_cache[bufnr]
  return cached and cached.diagnostics or ""
end

function _G.statusline_indent_segment()
  if not is_regular_buffer(api.nvim_get_current_buf()) then
    return ""
  end

  local width = vim.bo.shiftwidth > 0 and vim.bo.shiftwidth or vim.bo.tabstop
  return string.format("%s%d", vim.bo.expandtab and "SPA" or "TAB", width)
end

function _G.statusline_eol_segment()
  local bufnr = api.nvim_get_current_buf()
  if not is_regular_buffer(bufnr) then
    return ""
  end

  local label = vim.b.statusline_disk_eol or effective_eol(bufnr)
  return label
end

function _G.statusline_tools_segment()
  local bufnr = api.nvim_get_current_buf()
  if not is_regular_buffer(bufnr) then
    return ""
  end

  local cached = tool_cache[bufnr] or {}
  local parts = {}
  local show_names = vim.o.columns >= full_tool_names_min_columns

  local function add_tool(label, names)
    if not names or #names == 0 then
      return
    end

    if show_names then
      parts[#parts + 1] = string.format("(%s:%s)", label, table.concat(names, ","))
    else
      parts[#parts + 1] = "(" .. label .. ")"
    end
  end

  -- Preserve the active-tool indicators on narrow terminals without allowing
  -- their executable names to consume most of the statusline.
  add_tool("FMT", cached.formatters)
  add_tool("LIN", cached.linters)
  add_tool("LSP", cached.lsps)

  return table.concat(parts)
end

function M.setup()
  local group = api.nvim_create_augroup("CustomStatusBar", { clear = true })

  if vim.g[highlight_toggle_var] == nil then
    vim.g[highlight_toggle_var] = true
  end
  define_tab_cr_highlight()

  api.nvim_create_autocmd("DiagnosticChanged", {
    group = group,
    callback = function(ev)
      refresh_diagnostics(ev.buf)
    end,
  })

  api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function(ev)
      local needs_initial_state = tool_cache[ev.buf] == nil
      update_git_branch(ev.buf)
      if needs_initial_state then
        refresh_diagnostics(ev.buf)
        refresh_lsp_later(ev.buf)
      end
    end,
  })

  api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
    group = group,
    callback = function(ev)
      detect_disk_eol(ev.buf)
    end,
  })

  api.nvim_create_autocmd("FileChangedShellPost", {
    group = group,
    callback = function(ev)
      detect_disk_eol(ev.buf)
    end,
  })

  api.nvim_create_autocmd("BufFilePost", {
    group = group,
    callback = function(ev)
      update_git_branch(ev.buf, true)
      detect_disk_eol(ev.buf)
    end,
  })

  api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(ev)
      reset_execution_results(ev.buf)
      refresh_diagnostics(ev.buf)
      refresh_lsp_later(ev.buf)
    end,
  })

  api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
    group = group,
    callback = function(ev)
      refresh_lsp_later(ev.buf)
    end,
  })

  api.nvim_create_autocmd({ "DirChanged", "FocusGained", "ShellCmdPost", "TermClose" }, {
    group = group,
    callback = function(ev)
      -- Invalidate every buffer in O(1); each one refreshes only when entered.
      git_cache_generation = git_cache_generation + 1
      local bufnr = api.nvim_get_current_buf()
      local recompute_root = ev.event == "DirChanged" and api.nvim_buf_get_name(bufnr) == ""
      update_git_branch(bufnr, recompute_root)
    end,
  })

  api.nvim_create_autocmd("BufDelete", {
    group = group,
    callback = function(ev)
      tool_cache[ev.buf] = nil
      tool_refresh_pending[ev.buf] = nil
      eol_requests[ev.buf] = nil
    end,
  })

  api.nvim_create_autocmd({ "WinNew", "BufWinEnter" }, {
    group = group,
    callback = function()
      local winid = api.nvim_get_current_win()
      vim.schedule(function()
        sync_tab_cr_match(winid)
      end)
    end,
  })

  api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = define_tab_cr_highlight,
  })

  vim.keymap.set("n", "<Leader>tab", toggle_tab_cr_highlight, {
    desc = "Toggle red background for tabs and carriage returns",
  })

  vim.opt.laststatus = 3
  vim.opt.statusline = "%<%F %m"
    .. "%="
    .. "%{v:lua.statusline_git_branch_segment()}"
    .. "%( %{v:lua.statusline_diag_segment()}%)"
    .. "%( %{v:lua.statusline_indent_segment()}%)"
    .. "%( %{v:lua.statusline_eol_segment()}%)"
    .. "%( %{v:lua.statusline_tools_segment()}%)"
    .. " %y %l:%c %P"

  sync_all_tab_cr_matches()

  local bufnr = api.nvim_get_current_buf()
  update_git_branch(bufnr)
  refresh_diagnostics(bufnr)
  refresh_lsp_later(bufnr)
  if vim.v.vim_did_enter == 1 then
    detect_disk_eol(bufnr)
  end
end

return M
