return {
  'nvim-lua/plenary.nvim',       -- Common utilities
  'nvim-tree/nvim-web-devicons', -- Icons

  -- Colorscheme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup { dark_variant = 'moon' }
      vim.cmd('colorscheme rose-pine')
    end,
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    config = true,
    keys = {
      { '<C-n>',     ':NvimTreeToggle<CR>',   silent = true },
      { '<leader>n', ':NvimTreeFindFile<CR>', silent = true },
    }
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        section_separators = '',
        component_separators = '|',
      },
      extensions = { 'nvim-tree' }
    },
  },

  -- Comment
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    event = 'VeryLazy',
    opts = function()
      return { pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), }
    end,
  },

  -- Color highlighter
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'VeryLazy',
    config = true,
  },

  --Indent line
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    opts = {
      char = "▏",
      use_treesitter = true,
      show_first_indent_level = false,
      show_current_context = true,
      context_char = "▏",
    },
  },

  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = true,
  },

  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = true,
  },

  -- outline
  {
    'stevearc/aerial.nvim',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end
    },
    keys = {
      { "<leader>at", "<cmd>AerialToggle!<CR>", desc = "Aerial Toggle" },
    },
  },

  -- git labels
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = 'GS: stage hunk' })
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = 'GS: reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'GS: stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'GS: undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'GS: reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'GS: preview hunk' })
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = 'GS: blame line' })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'GS: toggle current line blame' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'GS: diff this' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'GS: toggle deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }
  },
}
