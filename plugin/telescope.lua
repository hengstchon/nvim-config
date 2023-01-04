local ok, telescope = pcall(require, 'telescope')
if not ok then
  print('Failed to load telescope')
  return
end

local builtin = require('telescope.builtin')
local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}

telescope.load_extension 'file_browser'
telescope.load_extension 'fzf'

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Tele: files in CWD' })
vim.keymap.set('n', '<leader>fa', function()
  builtin.find_files
  {
    follow = true,
    no_ignore = true,
    hidden = true,
  }
end, { desc = 'Tele: all files in CWD' })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Tele: previously open files' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Tele: search string in CWD' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Tele: search under cursor in CWD' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Tele: buffers' })
vim.keymap.set('n', '<leader>fp', builtin.resume, { desc = 'Tele: previous picker' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Tele: help tags' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Tele: normal mode keymappings' })
vim.keymap.set('n', '<leader>cm', builtin.git_commits, { desc = 'Tele: git commits with diff' })
vim.keymap.set('n', '<leader>bm', builtin.git_bcommits, { desc = "Tele: buffer's git commits with diff" })
vim.keymap.set('n', '<leader>gt', builtin.git_status, { desc = 'Tele: changes per file with diff' })
vim.keymap.set('n', '<leader>bf', builtin.current_buffer_fuzzy_find, { desc = 'Tele: search in buffer' })
vim.keymap.set('n', '<leader>fn', telescope.extensions.file_browser.file_browser, { desc = 'Tele: file browser' })
