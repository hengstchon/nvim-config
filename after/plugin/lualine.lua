local ok, lualine = pcall(require, "lualine")
if not ok then
  print("Failed to load lualine.nvim")
  return
end

lualine.setup {
  options = {
    section_separators = '',
    component_separators = '|',
  },
}
