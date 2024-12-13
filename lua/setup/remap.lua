-- NOTE: plugin specifig remaps are in plugins.lua

vim.g.mapleader = " "

-- buffer shortcuts
vim.keymap.set('n', '<C-n>', ':bnext<CR>', {desc = 'next buffer'})
vim.keymap.set('n', '<C-m>', ':bprevious<CR>', {desc = 'previous buffer'})
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', {desc = 'delete buffer'})

