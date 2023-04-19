return {
  -- typescript
  {
    'jose-elias-alvarez/typescript.nvim',
  },

  {
    'williamboman/mason.nvim',
    config = true,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    opts = { automatic_installation = true },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      --- diagnostics settings
      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = {
          -- from nvim_open_win()
          focusable = false,
          border = 'rounded',
          -- from vim.diagnostic.open_float()
          header = '',       -- default: Diagnostics
          source = 'always', -- show source if truthy
          prefix = '',       -- default: list number
        },
      })

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'rounded' }
      )

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded' }
      )

      -- formatting on save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
        end, bufopts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format() end, bufopts)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { '*.tsx', '*.ts' },
            group = augroup,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local nvim_lsp = require('lspconfig')
      require('mason-lspconfig').setup_handlers {
        function(server_name) -- default handler (optional)
          nvim_lsp[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end,
        ['lua_ls'] = function()
          nvim_lsp.lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
              },
            }
          }
        end,
        ['tsserver'] = function()
          require("typescript").setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false,            -- enable debug logging for commands
            go_to_source_definition = {
              fallback = true,        -- fall back to standard LSP definition on failure
            },
            server = {
              on_attach = on_attach,
              capabilities = capabilities,
            },
          })
        end,
        ['intelephense'] = function()
          nvim_lsp.intelephense.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
              storagePath = "/tmp/intelephense",
              licenceKey = "TTYS3",
            },
            settings = {
              intelephense = {
                files = {
                  -- Maximum file size in bytes
                  maxSize = 5000000,
                },
              },
            },
          }
        end,
      }
    end
  },

  -- formatting & diagnostics
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = "BufReadPre",
    dependencies = { "mason.nvim", "typescript.nvim" },
    opts = function()
      local nls = require('null-ls')
      local formatting = nls.builtins.formatting
      local diagnostics = nls.builtins.diagnostics
      return {
        sources = {
          formatting.prettierd,
          formatting.black,
          diagnostics.eslint_d,
          require("typescript.extensions.null-ls.code-actions"),
        },
      }
    end
  },

}
