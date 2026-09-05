-- nvim-cmp
local api = vim.api
local lsp = vim.lsp
local util = require("vim.lsp.util")
local signature_help_method = "textDocument/signatureHelp"

local ok_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities
if ok_cmp_lsp then
  capabilities = cmp_lsp.default_capabilities()
else
  capabilities = vim.lsp.protocol.make_client_capabilities()
end

-- Snippets are disabled by default. Servers that need them can override this
-- capability in their own lsp/<server>.lua configuration.
capabilities.textDocument.completion.completionItem.snippetSupport = false

vim.lsp.config("*", {
  capabilities = capabilities,
})

local float_opts = {
  border = "rounded",
  max_width = 100,
  max_height = 20,
  wrap = true,
  anchor_bias = "above",
}

-- Neovim's native signature window shows one overload at a time. This custom
-- implementation collects every signature returned by all attached LSPs and
-- displays them together, highlighting the active parameter in each overload.
local signature_group = api.nvim_create_augroup("LspMultiSignatureHelp", { clear = true })
local signature_sessions = {}
local signature_ns = api.nvim_create_namespace("LspMultiSignatureActiveParameter")

local function client_positional_params(params)
  local win = api.nvim_get_current_win()
  return function(client)
    local ret = util.make_position_params(win, client.offset_encoding)
    if params then
      ret = vim.tbl_extend("force", ret, params)
    end
    return ret
  end
end

local function collect_signatures(results)
  local signatures = {}
  local active_signature = 1

  for client_id, response in pairs(results) do
    local client = lsp.get_client_by_id(client_id)
    local result = response.result
    if client and result and result.signatures and result.signatures[1] then
      local base = #signatures
      for _, signature in ipairs(result.signatures) do
        signature.activeParameter = signature.activeParameter or result.activeParameter
        signatures[#signatures + 1] = { client = client, signature = signature }
      end

      local local_active = (result.activeSignature or 0) + 1
      if local_active >= 1 and local_active <= #result.signatures then
        active_signature = base + local_active
      end
    end
  end

  return signatures, active_signature
end

local function active_parameter_columns(signature, triggers)
  if not signature.parameters or #signature.parameters == 0 then
    return nil
  end

  local active_parameter = math.max(signature.activeParameter or 0, 0)
  active_parameter = math.min(active_parameter, #signature.parameters - 1)

  local parameter = signature.parameters[active_parameter + 1]
  local parameter_label = parameter.label
  if type(parameter_label) == "table" then
    return parameter_label[1], parameter_label[2]
  end

  local offset = 1
  for _, trigger in ipairs(triggers or {}) do
    local trigger_offset = signature.label:find(trigger, 1, true)
    if trigger_offset and (offset == 1 or trigger_offset < offset) then
      offset = trigger_offset
    end
  end

  for index, param in ipairs(signature.parameters) do
    local label = param.label
    if type(label) ~= "string" then
      break
    end

    offset = signature.label:find(label, offset, true)
    if not offset then
      break
    end

    if index == active_parameter + 1 then
      return offset - 1, offset + #parameter_label - 1
    end

    offset = offset + #label + 1
  end

  return nil
end

local function close_multi_signature_help(bufnr)
  local session = signature_sessions[bufnr]
  if not session then
    return
  end

  if session.win and api.nvim_win_is_valid(session.win) then
    pcall(api.nvim_win_close, session.win, true)
  end

  signature_sessions[bufnr] = nil
end

local function open_multi_signature_help(opts)
  opts = opts or {}
  local bufnr = api.nvim_get_current_buf()
  local session = signature_sessions[bufnr] or {}
  if session.pending then
    return
  end
  session.pending = true
  signature_sessions[bufnr] = session

  lsp.buf_request_all(bufnr, signature_help_method, client_positional_params(), function(results, ctx)
    local current = signature_sessions[ctx.bufnr]
    if current then
      current.pending = false
    end

    if api.nvim_get_current_buf() ~= ctx.bufnr then
      return
    end

    local signatures, active = collect_signatures(results)
    if not next(signatures) then
      close_multi_signature_help(ctx.bufnr)
      if opts.silent ~= true then
        vim.notify("No signature help available", vim.log.levels.INFO)
      end
      return
    end

    local total = #signatures
    local lines = {}
    local ranges = {}
    local client_names = {}
    local seen_clients = {}
    for i = 1, total do
      local entry = signatures[i]
      local marker = (i == active) and ">" or "-"
      local triggers = vim.tbl_get(entry.client.server_capabilities, "signatureHelpProvider", "triggerCharacters")
      local prefix = string.format("%s ", marker)
      local line = prefix .. entry.signature.label

      if not seen_clients[entry.client.name] then
        seen_clients[entry.client.name] = true
        client_names[#client_names + 1] = entry.client.name
      end

      lines[#lines + 1] = line

      local start_col, end_col = active_parameter_columns(entry.signature, triggers)
      if start_col and end_col then
        ranges[#ranges + 1] = {
          #lines - 1,
          #prefix + start_col,
          #lines - 1,
          #prefix + end_col,
        }
      end
    end

    local prev_win = current and current.win or nil
    local config = vim.tbl_extend("force", vim.deepcopy(float_opts), {
      focus_id = signature_help_method .. ".multi",
      title = string.format("Signature Help (%d shown) - %s", total, table.concat(client_names, ", ")),
      focusable = false,
      close_events = { "InsertLeave", "BufLeave", "BufHidden" },
      _update_win = prev_win,
    })

    local buf, win = util.open_floating_preview(lines, vim.bo[ctx.bufnr].filetype, config)
    api.nvim_buf_clear_namespace(buf, signature_ns, 0, -1)
    for _, hl in ipairs(ranges) do
      vim.hl.range(
        buf,
        signature_ns,
        "LspSignatureActiveParameter",
        { hl[1], hl[2] },
        { hl[3], hl[4] }
      )
    end

    signature_sessions[ctx.bufnr] = {
      active = true,
      pending = false,
      win = win,
    }
  end)
end

vim.api.nvim_create_autocmd({ "CursorMovedI", "TextChangedI" }, {
  group = signature_group,
  callback = function(ev)
    local session = signature_sessions[ev.buf]
    if not session or not session.active then
      return
    end
    open_multi_signature_help({ silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave", "BufHidden" }, {
  group = signature_group,
  callback = function(ev)
    close_multi_signature_help(ev.buf)
  end,
})

vim.diagnostic.config({
  underline = false, -- underline the problematic code
  virtual_text = {
    -- `current_line` is intentionally omitted: nil shows diagnostics on every line.
    spacing = 1,
    prefix = "!",
    source = true,
    virt_text_pos = "eol",
    virt_text_hide = false,
  },
  virtual_lines = false,
  signs = true,
  float = {
    scope = "line", -- "cursor"
    severity_sort = true,
    source = true,
  },
  update_in_insert = false,
  severity_sort = true,
})

-- Mappings
-- Diagnostics can also come from nvim-lint, so this mapping remains global.
vim.keymap.set({ "n", "v" }, "<Leader>ds", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- LSP actions are local to attached buffers, so they do not appear where no
-- language server is active.
local lsp_mappings_group = api.nvim_create_augroup("LspBufferMappings", { clear = true })
api.nvim_create_autocmd("LspAttach", {
  group = lsp_mappings_group,
  callback = function(ev)
    local client = lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    local function map(modes, lhs, rhs, desc)
      vim.keymap.set(modes, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    if client:supports_method("textDocument/rename", ev.buf) then
      map("n", "<Leader>ren", lsp.buf.rename, "LSP rename")
    end

    if client:supports_method("textDocument/codeAction", ev.buf) then
      map({ "n", "v" }, "<Leader>fx", lsp.buf.code_action, "LSP fix")
    end

    if client:supports_method("textDocument/hover", ev.buf) then
      map("n", "<C-Space>", function()
        lsp.buf.hover(float_opts)
      end, "LSP hover")
    end

    if client:supports_method(signature_help_method, ev.buf) then
      map("i", "<C-Space>", open_multi_signature_help, "LSP signature help (all overloads)")
    end
  end,
})

-- Enable servers only after all LspAttach handlers have been registered.
vim.lsp.enable({
  "clangd",
  "neocmakelsp",
})
