-- Set encoding to utf-8
vim.o.encoding = "utf-8"

-- Set space as the leader key
vim.g.mapleader = ' '

-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Replace escape with jj
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', 'jj', '<Esc>', { noremap = true, silent = true })

-- Disable arrow keys
vim.api.nvim_set_keymap('n', '<Left>', [[:echoe "Use 'h'"<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', [[:echoe "Use 'l'"<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Up>', [[:echoe "Use 'k'"<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', [[:echoe "Use 'j'"<CR>]], { noremap = true, silent = true })

-- Move cursos for J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Replace word under cursor
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Pasting without replacing the clipboard
vim.keymap.set("n", "<leader>p", "\"_dP")

-- Copying to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Deleting (using system clipboard)
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Indentation
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false

-- Show line numbers
vim.o.number = true
vim.o.numberwidth = 2
vim.o.relativenumber = true

-- Search settings
vim.o.hlsearch = false
vim.o.incsearch = true

-- Scroll settings
vim.o.scrolloff = 8

-- Enable mouse support
vim.o.mouse = 'a'

-- Allow certain keys to wrap around the end of lines
vim.o.whichwrap = vim.o.whichwrap .. '<,>,h,l'

-- Automatically remove trailing whitespace
vim.cmd([[autocmd BufWritePre <buffer> %s/\s\+$//e]])

-- Disable indentation on switch (C)
vim.o.cinoptions = 'l1'

-- Lazy Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
