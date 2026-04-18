local M = {}

local function update_git_branch()
    local file_dir = vim.fn.expand("%:p:h")
    if file_dir == "" then
        file_dir = vim.fn.getcwd()
    end

    local out = vim.fn.systemlist({ "git", "-C", file_dir, "branch", "--show-current" })
    if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
        vim.g.statusline_git_branch = out[1]
    else
        vim.g.statusline_git_branch = ""
    end
end

function _G.statusline_git_branch_segment()
    if vim.bo.filetype == "NvimTree" then
        return ""
    end

    local branch = vim.g.statusline_git_branch or ""
    if branch == "" then
        return ""
    end

    return "(" .. branch .. ")"
end

function _G.statusline_diag_segment()
    if vim.bo.filetype == "NvimTree" then
        return ""
    end

    local diagnostics = vim.diagnostic.get(0)
    local errors = 0
    local warnings = 0

    for _, d in ipairs(diagnostics) do
        if d.severity == vim.diagnostic.severity.ERROR then
            errors = errors + 1
        elseif d.severity == vim.diagnostic.severity.WARN then
            warnings = warnings + 1
        end
    end

    local parts = {}
    if errors > 0 then
        table.insert(parts, " E" .. errors)
    end
    if warnings > 0 then
        table.insert(parts, " W" .. warnings)
    end

    if #parts == 0 then
        return ""
    end

    return " " .. table.concat(parts, "")
end

function M.setup()
    vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged", "FocusGained" }, {
        callback = update_git_branch,
    })

    -- Redraw statusline when diagnostics change
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
        callback = function()
            vim.cmd("redrawstatus")
        end,
    })

    update_git_branch()

    vim.opt.laststatus = 3
    vim.opt.statusline = "%F" ..
                         "%m" ..
                         "%=" ..
                         "%{v:lua.statusline_git_branch_segment()}" ..
                         "%{v:lua.statusline_diag_segment()}" ..
                         " " ..
                         "%y" ..
                         " " ..
                         "%l" ..
                         ":" ..
                         "%c" ..
                         " " ..
                         "%P"
end

return M
