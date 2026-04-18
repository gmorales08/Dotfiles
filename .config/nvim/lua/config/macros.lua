-- MACROS

local M = {}

-- Para generar header de C y CPP
function M.generate_header()
    local filename = vim.fn.expand('%:t:r')
    local extension = string.upper(vim.fn.expand('%:e'))
    local guard = string.upper(filename:gsub('([A-Z])', '_%1'))
    guard = guard:gsub('^_', '')
    guard = guard .. '_' .. extension

    vim.fn.setline(1, '#ifndef ' .. guard)
    vim.fn.setline(2, '#define ' .. guard)
    vim.fn.setline(3, '')
    vim.fn.setline(4, '')
    vim.fn.setline(5, '')
    vim.fn.setline(6, '#endif /* ' .. guard .. ' */')

    vim.cmd('normal! 4G')
end

-- Para incluir header de C y CPP
function M.include_header()
    local ext = vim.fn.expand('%:e')
    if ext ~= 'cpp' and ext ~= 'c' then
        return
    end
    local filename = vim.fn.expand('%:t:r')
    local header_ext = (ext == 'cpp') and 'hpp' or 'h'
    local include_line = '#include "' .. filename .. '.' .. header_ext .. '"'

    vim.fn.append(0, include_line)
    vim.fn.append(1, '')
end

-- Asignar macros a registros
function M.setup()
    -- Macro @h: genera header y entra en insert mode
    vim.fn.setreg('h', ':lua require("config.macros").generate_header()\ri')
    
    -- Macro @i: incluye header
    vim.fn.setreg('i', ':lua require("config.macros").include_header()\r')
end

return M
