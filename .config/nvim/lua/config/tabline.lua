-- TAB BAR
-- Shows the buffers visible in each tab page.
-- A trailing * marks tabs that contain a modified buffer.
-- Tab labels can be clicked to switch to their tab page.

local M = {}

local function escape_tabline_text(text)
  -- The tabline uses statusline syntax, where % starts a format item.
  -- strtrans() also makes control characters in file names visible and harmless.
  return (vim.fn.strtrans(text):gsub("%%", "%%%%"))
end

local function tab_label(tabnr)
  local names = {}
  local seen_buffers = {}
  local has_modified_buffer = false

  -- tabpagebuflist() returns one buffer per window, so the same buffer may
  -- appear more than once when it is displayed in multiple splits.
  for _, bufnr in ipairs(vim.fn.tabpagebuflist(tabnr)) do
    if not seen_buffers[bufnr] then
      seen_buffers[bufnr] = true

      local buftype = vim.bo[bufnr].buftype
      local modifiable = vim.bo[bufnr].modifiable

      if buftype ~= "help" and buftype ~= "quickfix" and modifiable then
        local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
        if name ~= "" then
          names[#names + 1] = escape_tabline_text(name)
        end
      end

      if vim.bo[bufnr].modified then
        has_modified_buffer = true
      end
    end
  end

  local label = #names > 0 and table.concat(names, ", ") or "[New]"
  if has_modified_buffer then
    label = label .. "*"
  end

  return label
end

function M.my_tab_line()
  local parts = {}
  local current_tab = vim.fn.tabpagenr()
  local tab_count = vim.fn.tabpagenr("$")

  for tabnr = 1, tab_count do
    -- Associate the following label with its tab page for mouse clicks.
    parts[#parts + 1] = "%" .. tabnr .. "T"

    local highlight = tabnr == current_tab and "%#TabLineSel#" or "%#TabLine#"
    parts[#parts + 1] = highlight

    parts[#parts + 1] = " " .. tabnr
    parts[#parts + 1] = " " .. highlight
    parts[#parts + 1] = tab_label(tabnr)
    parts[#parts + 1] = " "
  end

  -- Reset the click target and fill the unused part of the tabline.
  parts[#parts + 1] = "%#TabLineFill#%T"

  -- Optional right-aligned close button:
  -- if tab_count > 1 then
  --   parts[#parts + 1] = "%=%#TabLineFill#%999Xclose"
  -- end

  return table.concat(parts)
end

function M.setup()
  -- Set the custom tab page line.
  vim.o.tabline = '%!v:lua.require("config.tabline").my_tab_line()'
end

return M
