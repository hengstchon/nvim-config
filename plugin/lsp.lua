---
-- 1. mason.nvim
---

local ok1, mason = pcall(require, 'mason')
if not ok1 then
  print("Failed to load mason.nvim")
  return
end

mason.setup()


---
-- 2. mason-lspconfig.nvim
---

local ok2, mason_lsp = pcall(require, 'mason-lspconfig')
if not ok2 then
  print("Failed to load mason-lspconfig.nvim")
  return
end

mason_lsp.setup {
  automatic_installation = true
}


---
-- 3. nvim-lspconfig
---

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
    header = '', -- default: Diagnostics
    source = 'always', -- show source if truthy
    prefix = '', -- default: list number
  },
})

--- nvim-lsp settings
local ok3, nvim_lsp = pcall(require, 'lspconfig')
if not ok3 then
  print("Failed to load nvim-lspconfig")
  return
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>fm', function()
    vim.lsp.buf.format()
  end, bufopts)
end

local ok4, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok4 then
  print("Failed to load cmp-nvim-lsp")
  return
end

local capabilities = cmp_nvim_lsp.default_capabilities()
mason_lsp.setup_handlers {
  function(server_name) -- default handler (optional)
    nvim_lsp[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
  ['sumneko_lua'] = function()
    nvim_lsp.sumneko_lua.setup {
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
