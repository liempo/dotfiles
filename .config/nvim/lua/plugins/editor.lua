return {
    { -- Commentary
        'tpope/vim-commentary',
        config = function()
            vim.cmd([[autocmd FileType swift setlocal commentstring=#\ %s]])
        end
    },

    { -- Surround
        'tpope/vim-surround'
    },

    {
        -- Formatter
        'stevearc/conform.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    swift = { 'swift_format' },
                },
                format_on_save = function(_)
                    return { timeout_ms = 200, lsp_fallback = true }
                end,
                log_level = vim.log.levels.ERROR,
            })
        end
    },

    { -- Code highlighting
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "lua", "vim", "html", "javascript", "typescript", "swift"
                },
                highlight = {
                    enable = { "svelte", "javascript", "typescript", "html", "css", "scss" }
                }
            })
        end
    },


    { -- Github Copilot
        'github/copilot.vim'
    }

}
