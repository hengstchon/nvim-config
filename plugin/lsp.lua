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
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  -- end, bufopts)
  -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
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


---
-- 4. lspsaga
---

local ok5, lspsaga = pcall(require, 'lspsaga')
if not ok5 then
  print("Failed to load lspsaga")
  return
end

lspsaga.init_lsp_saga()

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostics
-- vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnostic jump can use `<c-o>` to jump back
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

-- Hover Doc
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
