vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.clipboard:append 'unnamedplus' -- Copy/paste to system clipboard
vim.opt.swapfile = false -- Don't use swapfile
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- Autocomplete options

vim.wo.number         = true -- Show line number
vim.opt.signcolumn    = 'yes' -- always show
vim.opt.splitright    = true -- Vertical split to the right
vim.opt.splitbelow    = true -- Orizontal split to the bottom
vim.opt.hlsearch      = false
vim.opt.ignorecase    = true -- Ignore case letters when search
vim.opt.smartcase     = true -- Ignore lowercase for the whole pattern
vim.opt.linebreak     = true -- Wrap on word boundary
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.showmode      = false -- Not put a message in insert mode

vim.opt.smartindent = true -- Autoindent new lines
vim.opt.expandtab   = true -- Use spaces instead of tabs
vim.opt.tabstop     = 4 -- 1 tab == 2 spaces
vim.opt.shiftwidth  = 4 -- Shift 2 spaces when (auto)indent

vim.opt.updatetime = 250 -- ms to wait for trigger an event

vim.opt.shortmess:append 'I' -- Disable nvim intro


-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = '*',
})

-- Remove whitespace on save
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

-- Don't auto commenting new lines
vim.cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]

-- Remove line length marker for selected filetypes
vim.cmd [[
  autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0
]]

-- 2 spaces for selected filetypes
vim.cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,javascriptreact,typescript,typescriptreact,json,lua,yaml,prisma setlocal shiftwidth=2 tabstop=2
]]
