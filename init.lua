require("setup.lazy")
require("setup.remap")
print("hello. nvim init")

-- tabs and spaces
vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab = true

-- backspace to prev line
-- without this, you backspace is limited
vim.opt.backspace='indent,eol,start'

-- prevent concealing
vim.opt.conceallevel=0

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
vim.opt.ttimeout  = true          -- faster esc
vim.opt.ttimeoutlen=50     -- faster esc 50ms
vim.opt.colorcolumn='81'   -- show 80 column line
--filetype indent on     -- load filetype-specific indent files
--filetype plugin on     -- load filetype-specific plugin files

-- status line 
vim.opt.laststatus=2
vim.opt.showtabline=2
vim.opt.cmdheight=1
vim.opt.ruler=true
vim.opt.showmode=false


-- search options
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true


--colorscheme
-- set true colors
vim.opt.termguicolors = true
vim.opt.background='dark'
vim.cmd.colorscheme('tokyonight-storm')


vim.conceal_level = 0

-- faster Scroll (note that <C-u> and <C-d> are default, but with larger jump)
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
vim.opt.undodir = vim.fn.expand('$HOME/.nvim/$HOST/undodir')
vim.opt.undolevels = 5000
vim.opt.swapfile = true

-- create directories for undodir and backupdir, if they don't exist
if vim.fn.isdirectory(vim.fn.expand('$HOME/.nvim/$HOST/undodir')) == 0 then
  vim.fn.mkdir(vim.fn.expand('$HOME/.nvim/$HOST/undodir'), 'p')
end
if vim.fn.isdirectory(vim.fn.expand('$HOME/.nvim/$HOST/backupdir')) == 0 then
  vim.fn.mkdir(vim.fn.expand('$HOME/.nvim/$HOST/backupdir'), 'p')
end


--------------------- FILETYPE ------------------------------
-- filetype
vim.cmd('filetype plugin indent on')
-- julia python indent
vim.cmd('autocmd FileType julia setlocal shiftwidth=4 tabstop=4 softtabstop=4')
vim.cmd('autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4')


-- define glsl filetype
vim.cmd('autocmd BufNewFile,BufRead *.frag,*.vert,*.comp,*.glsl,*.rahit,*.rchit,*.rchit,*.rgen,*.rgen,*.rint set filetype=glsl')
vim.cmd('autocmd BufNewFile,BufRead *.wgsl set filetype=wgsl')
vim.treesitter.language.register("glsl", "glsl")

---------------------------------------------------
------------------------- PLUGINS ------------------------------
require('setup/plugins')

--------------------- LSP ------------------------------
local lsp = require('lsp-zero')

lsp.preset('recommended')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = {buffer = event.buf}

    -- if buffer is cpp or c
    -- then set formatting keymaps 
    if vim.bo.filetype == 'cpp' or vim.bo.filetype == 'c' or vim.bo.filetype ==
      'cuda' then vim.keymap.set({'n', 'x'}, 'gq', function()
        vim.lsp.buf.format({async = false, timeout_ms = 10000})
      end, opts)

      vim.keymap.set({'v'}, 'gq', function()
        vim.lsp.buf.format({async = false, timeout_ms = 10000})
      end, opts)
    end
  end
})

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
  ensure_installed = {
    'julials', 'clangd', 'matlab_ls', 'pyright', 
    'glsl_analyzer', 'markdown_oxide', 'wgsl_analyzer', 
    'jsonls', 'html', 'taplo'
  },
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


-- appearance (with no or few remaps)

----- indentline configuration
vim.g.indentLine_color_term = 243
vim.g.indentLine_char_list = {'|', '¦', '┆', '┊'}
