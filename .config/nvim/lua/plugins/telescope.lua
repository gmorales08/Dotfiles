return {
    'nvim-telescope/telescope.nvim', version = '*',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        require('telescope').setup({
            defaults = {
                -- Performance optimizations
                cache_picker = { num_pickers = 10 },
                dynamic_preview_title = true,
                path_display = { "truncate" },

                -- Layout
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "bottom",
                        preview_width = 0.6,
                    },
                    width = 0.99,
                    height = 0.99,
                    preview_cutoff = 1, -- Always show preview
                },
                sorting_strategy = "descending", -- Descending for bottom prompt

                -- Sorting and filtering performance
                file_sorter = require('telescope.sorters').get_fzf_sorter,
                generic_sorter = require('telescope.sorters').get_fzf_sorter,
            },
            pickers = {
                find_files = {
                    -- Use fd if available (faster than find)
                    find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' }
                },
                live_grep = {
                    -- Optimize ripgrep
                    additional_args = function()
                        return { "--hidden", "--no-ignore", "--smart-case" }
                    end
                }
            }
        })
        -- Needed for telescope-fzf-native
        require('telescope').load_extension('fzf')
        -- Mappings
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', function()
            builtin.find_files({
                hidden = true,
                no_ignore = true,
                file_ignore_patterns = {
                    "%.git/",
                    "%.cache/",
                    "%build/"
                }
            })
        end, { desc = 'Telescope find files (incluye dotfiles)' })
        vim.keymap.set('n', '<leader>fl', function()
            builtin.live_grep({
                hidden = true,
                no_ignore = true,
                file_ignore_patterns = {
                    "%.git/",
                    "%.cache/",
                    "%build/"
                }
            })
        end, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader><tab>', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<C-f>', builtin.current_buffer_fuzzy_find, { desc = 'Telescope current buffer' })
    end
}
