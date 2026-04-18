-- TAB BAR
-- Función que genera una tabbar cuando se abren buffers en tabs.
-- Solo muestra buffers activos
-- Los títulos de los tabs muestran el nombre del fichero y un * si está modificado
-- Se puede pulsar sobre los tabs para acceder a ellos

local M = {}

function M.my_tab_line()
  local s = ''

  -- loop through each tab page
  for i = 1, vim.fn.tabpagenr('$') do
    -- set the tab page number (for mouse clicks)
    s = s .. '%' .. i .. 'T'

    -- set color for tab number and title
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end

    -- set page number string
    s = s .. ' ' .. i .. ''

    -- get buffer names and statuses
    local n = ''  -- temp str for buf names
    local m = 0   -- &modified counter
    local buflist = vim.fn.tabpagebuflist(i)

    -- loop through each buffer in a tab
    for _, b in ipairs(buflist) do
      local buftype = vim.fn.getbufvar(b, "&buftype")
      local modifiable = vim.fn.getbufvar(b, "&modifiable")

      if buftype == 'help' then
        -- let n .= '[H]' .. vim.fn.fnamemodify(vim.fn.bufname(b), ':t:s/.txt$//')
      elseif buftype == 'quickfix' then
        -- let n .= '[Q]'
      elseif modifiable == 1 then
        n = n .. vim.fn.fnamemodify(vim.fn.bufname(b), ':t') .. ', '
      end

      if vim.fn.getbufvar(b, "&modified") == 1 then
        m = m + 1
      end
    end

    -- remove trailing ', '
    n = n:gsub(', $', '')

    -- add modified label
    if m > 0 then
      n = n .. '*'
    end

    if i == vim.fn.tabpagenr() then
      s = s .. ' %#TabLineSel#'
    else
      s = s .. ' %#TabLine#'
    end

    -- add buffer names
    if n == '' then
      s = s .. '[New]'
    else
      s = s .. n
    end

    -- switch to no underlining and add final space
    s = s .. ' '
  end

  s = s .. '%#TabLineFill#%T'

  -- right-aligned close button
  -- if vim.fn.tabpagenr('$') > 1 then
  --   s = s .. '%=%#TabLineFill#%999Xclose'
  -- end

  return s
end

function M.setup()
  -- Set custom tab pages line
  vim.o.tabline = '%!v:lua.require("config.tabline").my_tab_line()'
end

return M
