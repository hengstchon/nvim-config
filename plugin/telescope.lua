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
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'TS: previously open files' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'TS: search string in CWD' })
vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'TS: search under cursor in CWD' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'TS: buffers' })
vim.keymap.set('n', '<leader>fp', builtin.resume, { desc = 'TS: previous picker' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'TS: help tags' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'TS: normal mode keymappings' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'TS: diagnostics' })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'TS: references' })
vim.keymap.set('n', '<leader>cm', builtin.git_commits, { desc = 'TS: git commits with diff' })
vim.keymap.set('n', '<leader>bm', builtin.git_bcommits, { desc = "TS: buffer's git commits with diff" })
vim.keymap.set('n', '<leader>gt', builtin.git_status, { desc = 'TS: changes per file with diff' })
vim.keymap.set('n', '<leader>bf', builtin.current_buffer_fuzzy_find, { desc = 'TS: search in buffer' })
vim.keymap.set('n', '<leader>fn', telescope.extensions.file_browser.file_browser, { desc = 'TS: file browser' })
