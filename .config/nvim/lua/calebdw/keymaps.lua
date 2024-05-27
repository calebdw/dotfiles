local map = require('calebdw.util').map

-- Disable highlight after search with ESC
map('n', '<esc>', ':noh<cr>')

-- Fast exit from insert mode
map('i', 'jk', '<esc>')
map('i', 'kj', '<esc>')

-- Reselect block after indentation
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Keep cursor position after yanking
-- https://ddrscott.github.io/blog/2016/yank-without-jank
-- disabled yanking to '+' register for system keyboard
-- map('v.nore', 'y', 'myy`y')
-- map('v.nore', 'Y', 'myY`y')

-- Paste in visual mode without replacing yank
map('v', 'p', '"_dP')

-- Yank to / paste from system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>Y', '"+Y')
map({ 'n', 'v' }, '<leader>p', '"+p')
map({ 'n', 'v' }, '<leader>P', '"+P')

-- Easily insert trailing chars in insert mode
map('i', ';;', '<esc>A;')
map('i', ',,', '<esc>A,')
map('i', '))', '<esc>A)')
map('i', ']]', '<esc>A]')

-- Jump to line start/end
map({ 'n', 'v' }, 'H', '^')
map({ 'n', 'v' }, 'L', '$')

-- Tabs --
map('n', '<leader>ct', ':tabc<cr>')
map('n', '<leader>st', ':tab split<cr>')
map('n', '<leader>tn', ':tab new<cr>')
map('n', '<leader>to', ':tabonly<cr>')

-- Sorting --
map('n', '<leader>so', 'vi[:sort<cr>')
map('v', '<leader>so', ':sort<cr>')

-- Alignment --
map('n', '<leader>a=', 'vi[:EasyAlign=<cr>')

-- Quickfix --
map({ 'n', 'v' }, '<leader>qc', ':call setqflist([])<cr>')

-- Vim-Easy-Align --
map({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)')

-- Ansible Playbooks --
map('n', '<leader>ap', ':Start ansible-playbook % -kK<cr>')

-- Terminal
map('t', '<esc><esc>', '<C-\\><C-n>')
map('t', '<C-h>', ':wincmd h<cr>')
map('t', '<C-j>', ':wincmd j<cr>')
map('t', '<C-k>', ':wincmd k<cr>')
map('t', '<C-l>', ':wincmd l<cr>')

-- Diagnostics
map('n', '<leader>d', vim.diagnostic.open_float)
map('n', '<leader>qd', vim.diagnostic.setloclist)

map('n', '<leader>gg', function()
  vim.ui.open('https://github.com/' .. vim.fn.expand('<cfile>'))
end, { desc = 'Open GitHub repo' })
