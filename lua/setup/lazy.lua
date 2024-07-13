-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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


plugins = {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  "folke/tokyonight.nvim",
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  -- NOTE: if you want to see icons, install nerd-fonts in the system which runs terminal
  -- https://www.nerdfonts.com/font-downloads
  
  -- language syntax parser
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  "nvim-treesitter/playground",

  -- copilot
  "github/copilot.vim",

  -- undo tree
  "mbbill/undotree",

  -- lsp
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},

  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},

  -- julia format
  "kdheepak/JuliaFormatter.vim",

  -- highlighting
  "yggdroot/indentline",
  "andymass/vim-matchup",
  "machakann/vim-highlightedyank",

  -- git integration(use ":Git" command)
  "tpope/vim-fugitive",

  -- ctags
  "universal-ctags/ctags",

  -- highlights TODO, FIXME, etc.
  -- NOTE: use ":TodoTelescope" command to see all the todos
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup{}
    end
  },

  -- status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- bufferline
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  
  -- fzf command line completion
  "gelguy/wilder.nvim",

  -- aerial => A code outline window for skimming and quick navigation
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  }
}


require("lazy").setup(plugins)


