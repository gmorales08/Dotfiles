local startup_root = vim.fn.getcwd()

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  config = function()
    local api = require('nvim-tree.api')

    local function on_attach(bufnr)
      -- Default keymaps
      api.map.on_attach.default(bufnr)

      -- m to open the menu help
      vim.keymap.set({'n','v'}, 'm', api.tree.toggle_help, { buffer = bufnr, desc = 'Toggle help menu' })

      -- Open the selected file in a vertical split (only inside NvimTree)
      -- Necessary when the terminal intercepts Ctrl-V for paste.
      vim.keymap.set('n', '<C-w>v', api.node.open.vertical, {
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
        desc = 'NvimTree: open in vertical split',
      })
    end

    require('nvim-tree').setup({
      on_attach = on_attach,
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = true,
            git = false,
          },
          symlink_arrow = " -> ",
          glyphs = {
            folder = {
              arrow_closed = ">",
              arrow_open = "v",
            },
          },
        },
        add_trailing = true, -- Add "/" at the end of the directories
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
        custom = { "undodir/" },
      },
      tab = {
        sync = {
          open = false,
          close = true,
        },
      },
    })

    vim.keymap.set('n', '<leader>nt', function()
      api.tree.find_file({
        open = true,
        focus = true,
        update_root = true,
      })
    end, { desc = 'NvimTree: current file' })

    vim.keymap.set('n', '<leader>nnt', function()
      api.tree.open({ path = startup_root })
      api.tree.change_root(startup_root)
    end, { desc = 'NvimTree: startup root' })
  end
}
