local ok, colorscheme = pcall(require, 'rose-pine')
if not ok then
  print('Failed to load colorscheme plugin')
  return
end

colorscheme.setup({
  dark_variant = 'moon'
})

-- set colorscheme after options
vim.cmd('colorscheme rose-pine')
