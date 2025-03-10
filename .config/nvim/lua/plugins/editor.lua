return {
  { -- Commentary
    'tpope/vim-commentary',
    config = function()
      vim.cmd([[autocmd FileType swift setlocal commentstring=//\ %s]])
    end
  },

  { -- Context based comments
    'JoosepAlviste/nvim-ts-context-commentstring'
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
          typescript = { 'prettierd' },
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
          "lua", "vim", "html", "javascript", "typescript", "swift"
        },
        highlight = {
          enable = true,
        },
      })
    end
  },

}
