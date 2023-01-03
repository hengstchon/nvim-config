local ok, indent_blankline = pcall(require, 'indent_blankline')
if not ok then
  print('Failed to load indent-blankline.nvim')
  return
end

indent_blankline.setup {
  char = "▏",
  use_treesitter = true,
  show_first_indent_level = false,
  show_current_context = true,
  context_char = "▏",
}
