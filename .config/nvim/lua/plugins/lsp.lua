return {
    { -- Language Support
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP
            { 'neovim/nvim-lspconfig', },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp',      event = 'InsertEnter' },
            { 'hrsh7th/cmp-nvim-lsp' },
            -- Snippets
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            local lspconfig = require('lspconfig')
            local cmp = require('cmp')
            lspconfig.denols.setup {
                root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            }
            lspconfig.tsserver.setup {
                root_dir = lspconfig.util.root_pattern("package.json"),
                single_file_support = false,
            }
            lspconfig.svelte.setup {}
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            }
            lspconfig.sourcekit.setup {
                cmd = { "/usr/bin/sourcekit-lsp" },
                capabilities = {
                    workspace = {
                        dynamicRegistration = true,
                    }
                },
            }
            lsp_zero.on_attach(
                function(_, bufnr)
                    lsp_zero.default_keymaps({ buffer = bufnr })
                    vim.keymap.set(
                        'n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr }
                    )
                end
            )
            lsp_zero.set_server_config({
                on_init = function(client)
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })
            cmp.setup {
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                }),
            }
        end
    }
}
