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
--vim.opt.smartcase = true


-- for vim-airline
-- vim.opt.noshowmode=true
vim.opt.laststatus=2
vim.opt.showtabline=2
vim.opt.cmdheight=1
vim.opt.ruler=true
vim.opt.showmode=false

--colorscheme
vim.cmd('colorscheme rose-pine')

-- tmux color
-- vim.opt.background='dark'
vim.opt.termguicolors = true


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

-- netrw error
vim.g.loaded_netrw = 0
