-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- fuzzy finder nvim plugin
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  --color scheme
  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })

  -- language syntax parser
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  -- access parsertree directly
  use('nvim-treesitter/playground')

  --copilot
  use('github/copilot.vim')
  
  --

  use('mbbill/undotree')

  use('tpope/vim-fugitive')

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment the two plugins below if you want to manage the language servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  {'neovim/nvim-lspconfig'},
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }

  -- gui related plugins
  use('vim-airline/vim-airline')
  use('vim-airline/vim-airline-themes')

  -- file explorer
  use('nvim-tree/nvim-tree.lua')
  use('nvim-tree/nvim-web-devicons') -- optional, file icon

  --autocomplete
  --use('CmdlineComplete')

  -- highlighting
  use('yggdroot/indentline')
  use('andymass/vim-matchup')
  use('machakann/vim-highlightedyank')

  -- ctags jumping
  use('universal-ctags/ctags')

  -- using system clipboard
  -- use('christoomey/vim-system-copy')

  use('sakshamgupta05/vim-todo-highlight')

end)
