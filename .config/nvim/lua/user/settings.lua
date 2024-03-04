local opt = vim.opt
local g = vim.g

-- Faster loading for providers
g.node_host_prog = '/usr/bin/neovim-node-host'
g.python3_host_prog = '/usr/bin/python3'
g.ruby_host_prog = '/usr/bin/ruby'

-- Override leader
g.mapleader = ' '
g.maplocalleader = ' '

-- White characters --
opt.smartindent = true -- reacts to syntax of code (e.g., C)
opt.tabstop = 4        -- 1 tab = 4 columns
opt.shiftwidth = 4     -- indentation rule (<< >>)
opt.expandtab = true   -- expand tab to spaces
-- q: comment formatting; n: numbered lists; j: remove comment when joining lines; 1: don't break after one-letter word
opt.formatoptions = 'qnj1'
opt.breakindent = true -- indent when breaking lines

-- Backup files --
opt.backup = true
opt.writebackup = false -- do not write/delete backup upon successful save
opt.swapfile = true
opt.undofile = true
opt.backupdir:remove('.') -- keep backups out of the current directory

-- Splitting --
opt.splitbelow = true
opt.splitright = true
opt.inccommand = 'split' -- preview substitutions in a split

-- Line numbers --
opt.number = true
-- opt.cursorline = true -- shows current line
opt.relativenumber = true -- shows relative numbers

-- Hidden buffers --
opt.hidden = true

-- Transparency in popup menu (required for cmp-tailwind-colors) --
opt.pumblend = 15

-- Searching --
opt.ignorecase = true
opt.smartcase = true -- case-sensitive when not all lower

-- Wildmenu --
opt.wildmode = { 'longest', 'list:longest' }
-- wildmenu?
-- opt.completeopt = { 'menuone', 'longest', 'preview' }
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Clipboard --
-- opt.clipboard = 'unnamedplus'

-- Path --
opt.path:append('**') -- Enables recursive sub-directory searching

-- Mouse --
opt.mouse = 'a'

-- Character Limit Warning --
opt.colorcolumn = '80'

-- Confirm saving --
opt.confirm = true

-- Hidden Chars --
opt.list = true
opt.listchars = { tab = '» ', trail = '⋅', nbsp = '␣', eol = '↴' }
opt.termguicolors = true

-- Scrolling --
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Session Options --
opt.sessionoptions = { 'curdir', 'folds', 'tabpages', 'winsize', 'winpos' }

-- Spell Check --
opt.spell = true
opt.spelllang = 'en_us'

-- Error Formats --
opt.errorformat = { '%-G#%.%#' }  -- ignores comment lines
opt.errorformat:append("%f|%l col %c|%m")
opt.errorformat:append('%-G%.%#') -- ignores all other unmatched lines

-- Folding --
vim.opt.foldmethod     = 'expr'
vim.opt.foldexpr       = 'v:lua.vim.treesitter.foldexpr()'
opt.foldenable = false -- zi toggles
-- opt.foldlevel = 99

-- Sign Column
opt.signcolumn = 'yes:2'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300 -- time for a mapped sequence to complete

opt.showmode = false     -- already shown in statusline

-- Diagnostic config
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
  float = {
    source = 'always',
    border = 'rounded',
  },
})

vim.fn.sign_define({
  { name = 'DiagnosticSignError', text = '', texthl = 'DiagnosticSignError' },
  { name = 'DiagnosticSignWarn', text = '', texthl = 'DiagnosticSignWarn' },
  { name = 'DiagnosticSignInfo', text = '', texthl = 'DiagnosticSignInfo' },
  { name = 'DiagnosticSignHint', text = '', texthl = 'DiagnosticSignHint' },
})

-- Filetypes --
vim.filetype.add({
  extension = {
    keymap = 'dts',
    neon = 'yaml',
    overlay = 'dts',
  },
  pattern = {
    -- ['.*%.blade%.php'] = 'blade.html.php',
    -- ['.*%.blade%.php'] = 'html.blade.php',
    ['.*%.antlers%.html'] = 'antlers.html',
    ['.*%.blade%.php'] = 'blade',
    ['.*%.neon%.dist'] = 'yaml',
  },
})
