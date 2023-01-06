-- Install packer.nvim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'kyazdani42/nvim-web-devicons' -- Icons
  use 'nvim-tree/nvim-tree.lua' -- File explorer
  use 'nvim-lualine/lualine.nvim' -- Status line
  use 'numToStr/Comment.nvim' -- Comment
  use 'norcalli/nvim-colorizer.lua'
  use { 'rose-pine/neovim', as = 'rose-pine' } -- Color scheme
  use 'lukas-reineke/indent-blankline.nvim' --Indent line
  use 'windwp/nvim-autopairs'
  use 'kylechui/nvim-surround'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag' -- auto close and auto rename html tag

  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- LSP
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

  -- Autocompletion
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-buffer' -- current file
  use 'hrsh7th/cmp-path' -- filesystem
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lua' -- neovim's lua api
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- snippet engine
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind.nvim'

  use 'jose-elias-alvarez/null-ls.nvim'

  use 'lewis6991/gitsigns.nvim' -- git labels


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
