local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local default = augroup('user_default', { clear = true })

-- File Formats
local file_formats = augroup('user_file_formats', { clear = true })

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = file_formats,
  pattern = '*.qf',
  callback = function()
    vim.bo.filetype = 'sh'
  end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = file_formats,
  pattern = '*.nvim',
  callback = function()
    vim.bo.syntax = 'vim'
    vim.bo.filetype = 'vim'
  end,
})

-- Turn off spellchecking in Terminal Windows
autocmd({ 'TermOpen' }, {
  group = default,
  pattern = '*',
  callback = function()
    vim.wo.spell = false
  end,
})

autocmd({ 'TextYankPost' }, {
  desc = 'Highlight when yanking text',
  group = default,
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd({ 'FileType' }, {
  desc = 'Force commentstring to include spaces',
  group = default,
  callback = function(event)
    local cs = vim.bo[event.buf].commentstring
    vim.bo[event.buf].commentstring = cs:gsub('(%S)%%s', '%1 %%s'):gsub('%%s(%S)', '%%s %1')
  end,
})
