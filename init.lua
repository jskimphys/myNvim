require("theprimeagen.lazy")
require("theprimeagen.remap")
print("hello. nvim init")

-- tabs and spaces
vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab = true

-- backspace to prev line
-- without this, you backspace is limited
vim.opt.backspace='indent,eol,start'

--- ui configs
vim.opt.number = true 
vim.opt.showcmd  = true 
vim.opt.cursorline = true  -- highlight current line
vim.opt.showmatch = true         -- show matching [{()}]
vim.opt.wildmenu = true          -- autocomplete for command line
vim.opt.updatetime=100     -- some plugins require fast update time
vim.opt.ttyfast = true            -- Improve redrawing
vim.opt.mouse='a'           -- mouse support - necessary evil
vim.opt.encoding='utf-8'     -- set korean incodings
vim.opt.termencoding='utf-8' -- set korean incodings
vim.opt.ttimeout  = true          -- faster esc
vim.opt.ttimeoutlen=50     -- faster esc 50ms
vim.opt.clipboard='unnamedplus'
--filetype indent on     -- load filetype-specific indent files
--filetype plugin on     -- load filetype-specific plugin files

-- search options
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true


-- for vim-airline
-- vim.opt.noshowmode=true
vim.opt.laststatus=2
vim.opt.showtabline=2
vim.opt.cmdheight=1
vim.opt.ruler=true
vim.opt.showmode=false

--colorscheme
-- set true colors
vim.opt.termguicolors = true
vim.opt.background='dark'
vim.cmd.colorscheme('tokyonight-storm')


-- faster Scroll
vim.keymap.set('n', '<C-e>', '10<C-e>', { desc = 'faster scroll' })
vim.keymap.set('n', '<C-y>', '10<C-y>', { desc = 'faster scroll' })

-- copy and paster from system clipboardv
vim.opt.clipboard='unnamedplus'
vim.keymap.set('n', '<leader>y', '\"+y', { desc = 'copy to system clipboard' })
vim.keymap.set('n', '<leader>d', '\"+d', { desc = 'copy to system clipboard' })
vim.keymap.set('n', '<leader>pm', ':set paste<CR>', { desc = 'set paste mode' })
vim.keymap.set('n', '<leader>pn', ':set nopaste<CR>', { desc = 'unset paste mode' })

-- history
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('$HOME/.nvim/undodir')
vim.opt.undolevels = 5000
vim.opt.swapfile = true
vim.opt.directory = vim.fn.expand('$HOME/.nvim/swapdir')


-- create directories for undodir and backupdir
if vim.fn.isdirectory(vim.fn.expand('$HOME/.nvim/undodir')) == 0 then
  vim.fn.mkdir(vim.fn.expand('$HOME/.nvim/undodir'), 'p')
end
if vim.fn.isdirectory(vim.fn.expand('$HOME/.nvim/swapdir')) == 0 then
  vim.fn.mkdir(vim.fn.expand('$HOME/.nvim/swapdir'), 'p')
end

-- filetype
vim.cmd('filetype plugin indent on')
-- julia python indent
vim.cmd('autocmd FileType julia setlocal shiftwidth=4 tabstop=4 softtabstop=4')
vim.cmd('autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4')

--------------------- Plugins ---------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sG', builtin.git_files, {})
vim.keymap.set('n', '<leader>sb', builtin.buffers, {})

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
-- define glsl filetype
vim.cmd('autocmd BufNewFile,BufRead *.frag,*.vert,*.comp set filetype=glsl')
vim.cmd('autocmd BufNewFile,BufRead *.wgsl set filetype=wgsl')
vim.treesitter.language.register("glsl", "glsl")

--------------------- LSP ------------------------------
local lsp = require('lsp-zero')

lsp.preset('recommended')

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete()
})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  -- NOTE: check the available servers here
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {'julials', 'clangd', 'matlab_ls', 'pyright', 'glsl_analyzer', 'markdown_oxide', 'wgsl_analyzer'},
  -- clangd setup
  clangd = {
    cmd = {'clangd', '--background-index', '--query-driver=/usr/bin/c++'},
    filetypes = {'c', 'cc', 'cpp', 'h', 'hh', 'hpp', 'objc', 'objcpp'},
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})
---------------------------------------------------


----- julia formatter
vim.keymap.set('n', '<leader>jf', ':JuliaFormatterFormat<CR>', { noremap = true })

vim.g.JuliaFormatter_options = {
    indent = 4,
    margin = 92,
    always_for_in = true,
    whitespace_typedefs = false,
    whitespace_ops_in_indices = true,
}


----- indentline configuration
vim.g.indentLine_color_term = 243
vim.g.indentLine_char_list = {'|', '¦', '┆', '┊'}

-----  bufferline configuration
require("bufferline").setup{}

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
