-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local opt = vim.opt -- Set options (global/buffer/windows-scoped)
local cmd = vim.cmd -- Execute Vim commands
local g = vim.g -- Global variables
local exec = vim.api.nvim_exec -- Execute Vimscript

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a' -- Enable mouse support
opt.clipboard = 'unnamedplus' -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = 'menuone,noselect' -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.showmatch = true -- Highlight matching parenthesis
opt.foldmethod = 'indent' -- Enable folding
opt.foldlevel = 99 -- Close no folds
opt.colorcolumn = '280' -- Line lenght marker at 280 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Orizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.showmode = false -- Not put a message in insert mode

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.smartindent = true -- Autoindent new lines
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 4 -- 1 tab == 2 spaces
opt.shiftwidth = 4 -- Shift 2 spaces when (auto)indent

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 200 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

-- Disable nvim intro
opt.shortmess:append "sI"

-- Disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------

-- Highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=400}
  augroup end
]], false)

-- Remove whitespace on save
cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

-- Don't auto commenting new lines
cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]

-- Remove line length marker for selected filetypes
cmd [[
  autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0
]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,javascriptreact,typescript,typescriptreact,json,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-- audo indent for php
cmd [[
  autocmd FileType php setlocal smartindent autoindent
]]
