local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- Clear search highlighting with <leader> and c
map('n', '<leader><CR>', ':nohlsearch<CR>')

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- virtual select movement
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Fast saving and quit
map('n', '<M-w>', ':w<CR>')
map('i', '<M-w>', '<C-c>:w<CR>')
map('n', '<M-q>', ':q<CR>')

-- Resize splits with arrow keys
map('n', '<up>', ':res +5<CR>')
map('n', '<down>', ':res -5<CR>')
map('n', '<left>', ':vertical resize-5<CR>')
map('n', '<right>', ':vertical resize+5<CR>')

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>') -- open/close
map('n', '<leader>n', ':NvimTreeFindFile<CR>') -- search file

-- telescope.nvim
map('n', '<leader>ff', '<cmd>Telescope find_files <cr>')
map("n", '<leader>fa', "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>")
map("n", '<leader>fo', "<cmd>Telescope oldfiles <cr>")
map('n', '<leader>fw', '<cmd>Telescope live_grep <cr>')
map("n", '<leader>fs', "<cmd>Telescope grep_string <cr>")
map('n', '<leader>fb', '<cmd>Telescope buffers <cr>')
map('n', '<leader>fp', '<cmd>Telescope resume <cr>')
map("n", '<leader>cm', "<cmd>Telescope git_commits <cr>")
map("n", '<leader>gt', "<cmd>Telescope git_status <cr>")
map('n', '<leader>fh', '<cmd>Telescope help_tags <cr>')
