return {

    { -- Tokyo night
        'folke/tokyonight.nvim',
        config = function()
            vim.cmd('colorscheme tokyonight-night')
        end
    },

    { -- Dashboard
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true
                    }
                }
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },

    { -- File Explorer
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup {
                view = {
                    width = 30,
                },
                update_focused_file = {
                    enable = true
                },
                renderer = {
                    group_empty = true
                }
            }
            vim.api.nvim_set_keymap('n', '<Leader>s', ':NvimTreeToggle<CR>', {
                noremap = true, silent = true
            })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },


    { -- Status line
        'nvim-lualine/lualine.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true
                }
            }
        end
    },

    { -- Bufferline
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        init = function() vim.g.barbar_auto_setup = false end,
        config = function()
            require('barbar').setup {
                auto_hide = true,
            }
            vim.api.nvim_set_keymap('n', '<leader>hh', ':BufferPrevious<CR>', {
                noremap = true, silent = true
            })
            vim.api.nvim_set_keymap('n', '<leader>ll', ':BufferNext<CR>', {
                noremap = true, silent = true
            })
            vim.api.nvim_set_keymap('n', '<leader>HH', ':BufferMovePrevious<CR>', {
                noremap = true, silent = true
            })
            vim.api.nvim_set_keymap('n', '<leader>LL', ':BufferMoveNext<CR>', {
                noremap = true, silent = true
            })
            vim.api.nvim_set_keymap('n', '<leader>q', ':BufferClose<CR>', {
                noremap = true, silent = true
            })
            vim.api.nvim_set_keymap('n', '<leader>Q', ':BufferClose!<CR>', {
                noremap = true, silent = true
            })
        end
    },

    { -- Fuzzy search
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        pickers = {
            'find_files',
            'live_grep',
            'buffers',
            'help_tags'
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
    },

}
