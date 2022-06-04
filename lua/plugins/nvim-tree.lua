-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- url: https://github.com/kyazdani42/nvim-tree.lua

-- Keybindings are defined in `core/keymaps.lua`:
-- https://github.com/kyazdani42/nvim-tree.lua#keybindings

-- Note: options under the g: command should be set BEFORE running the
-- setup function: https://github.com/kyazdani42/nvim-tree.lua#setup
-- Default options ARE NOT included.
-- See: `:help NvimTree`

local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

-- Call setup:
--- Each of these are documented in `:help nvim-tree.OPTION_NAME`
nvim_tree.setup {
  update_cwd = true,
  respect_buf_cwd = true,
  renderer = {
    highlight_opened_files = 'name',
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  actions = {
    change_dir = { enable = false },
  },
  filters = {
    dotfiles = true,
    custom = { 'node_modules', '.cache', '.bin' },
  },
}
