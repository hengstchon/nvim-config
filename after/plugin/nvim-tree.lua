local ok, nvim_tree = pcall(require, 'nvim-tree')
if not ok then
  print('Failed to load nvim-tree')
  return
end

nvim_tree.setup()
