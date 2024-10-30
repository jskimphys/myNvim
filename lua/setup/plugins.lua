
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
vim.keymap.set('n', '<leader>sF', builtin.find_files, {desc = 'find files'})
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {desc = 'live grep'})
vim.keymap.set('n', '<leader>sf', builtin.git_files, {desc = 'find git files'})
vim.keymap.set('n', '<leader>sb', builtin.buffers, {desc = 'find buffers'})
vim.keymap.set('n', '<leader>ss', builtin.grep_string, {desc = 'grep string under cursor'})
vim.keymap.set('n', '<leader>sT', builtin.treesitter, {desc = 'treesitter'})

vim.keymap.set('n', '<leader>lr', builtin.lsp_references, {desc = 'lsp references'})
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, {desc = 'lsp definitions'})
vim.keymap.set('n', '<leader>lim', builtin.lsp_implementations, {desc = 'lsp implementations'})
vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions, {desc = 'lsp type definitions'})

vim.keymap.set('n', '<leader>lic', builtin.lsp_incoming_calls, {desc = 'lsp incoming calls'})
vim.keymap.set('n', '<leader>loc', builtin.lsp_outgoing_calls, {desc = 'lsp outgoing calls'})


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
  ensure_installed = { 
    "c", "cpp", "rust", "python", 
    "matlab", "julia", "glsl", "wgsl",
    "javascript", "typescript", "html", "css", "scss", 
    "json", "yaml", "toml",
    "lua", "vim", "vimdoc", "query", 
  },
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



-- bufferline
require("bufferline").setup({
  options = {
    mode = "buffers",
    themable = true,
    max_name_lenght = 24,
    tab_size = 22,

    numbers = function(opts)
      return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
    end,
    close_command = "bdelete! %d",
    indicator ={
      style = "underline",
    },
    separator_style = "slope",
  },
})


----- lua line configuration
require('lualine').setup({
  options = {
    theme = 'ayu_dark'
  }
})

local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlights = {
      border = 'Normal', -- highlight to use for the border
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
    min_width = '40%',
  })
))

-- gitsigns: git integration lines-by-lines
require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

