return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  config = function()
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      -- Default keymaps
      api.config.mappings.default_on_attach(bufnr)

      -- m to open the menu help
      vim.keymap.set({'n','v'}, 'm', api.tree.toggle_help, { buffer = bufnr, desc = 'Toggle help menu' })
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
    })

    vim.keymap.set({'n','v'}, '<leader>nt', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
    vim.keymap.set({'n','v'}, '<leader>nnt', ':NvimTreeOpen<CR>', { desc = 'Open file tree' })
  end
}
