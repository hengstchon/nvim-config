local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  print("Failed to load null-ls")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  sources = {
    formatting.prettierd,
    formatting.black,
    diagnostics.eslint_d,
  },
}
