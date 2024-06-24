
--------------------- Plugins ---------------------


-- Telescope
require('telescope').setup({
  defaults = {
    layout_config = {
      vertical = {
        width = 0.9,
        height = 0.9,
      },
    },
  },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sT', ':Telescope<CR>', { desc = 'show all telescope commands' })
vim.keymap.set('n', '<leader>sF', builtin.find_files, {desc = 'find files'})
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {desc = 'live grep'})
vim.keymap.set('n', '<leader>sf', builtin.git_files, {desc = 'find git files'})
vim.keymap.set('n', '<leader>sb', builtin.buffers, {desc = 'find buffers'})
vim.keymap.set('n', '<leader>ss', builtin.grep_string, {desc = 'grep string under cursor'})


-- NvimTree
--------------------- nvim-tree ---------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_hijack_netrw = true
-- empty setup using defaults
require("nvim-tree").setup()
vim.keymap.set('n', '<leader>nn', ':NvimTreeToggle<CR>', { desc = 'toggle nvim-tree' })
vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>', { desc = 'find file in nvim-tree' })
-- OR setup with some options
--require("nvim-tree").setup({
--  sort = {
--    sorter = "case_sensitive",
--  },
--  view = {
--    width = 30,
--  },
--  renderer = {
--    group_empty = true,
--  },
--  filters = {
--    dotfiles = true,
--  },
-------------------------------------------------------


----- undo-tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

------------------- treesitter ---------------------
local ts = require('nvim-treesitter.configs')
ts.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "glsl", "python", "julia", "cpp", "rust", "bash", "wgsl", "matlab", "markdown" },
  highlight = {
    enable = true,
  },
  -- this is experimental
  indent = {
    enable = true,
  },
}

-- aerial => A code outline window for skimming and quick navigation
require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
