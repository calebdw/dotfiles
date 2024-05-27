local default = vim.api.nvim_create_augroup('user_default', { clear = true })

-- File Formats
local file_formats = vim.api.nvim_create_augroup('user_file_formats', { clear = true })

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = file_formats,
  pattern = '*.qf',
  callback = function()
    vim.bo.filetype = 'sh'
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = file_formats,
  pattern = '*.nvim',
  callback = function()
    vim.bo.syntax = 'vim'
    vim.bo.filetype = 'vim'
  end,
})

-- Turn off spellchecking in Terminal Windows
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  group = default,
  pattern = '*',
  callback = function()
    vim.wo.spell = false
  end,
})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  desc = 'Highlight when yanking text',
  group = default,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  desc = 'Force commentstring to include spaces',
  group = default,
  callback = function(event)
    local cs = vim.bo[event.buf].commentstring
    vim.bo[event.buf].commentstring = cs:gsub('(%S)%%s', '%1 %%s'):gsub('%%s(%S)', '%%s %1')
  end,
})

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  desc = 'Clean up old files in the state directory.',
  group = default,
  callback = function()
    local days = 30
    local cwd = vim.fn.stdpath('state')

    if type(cwd) == 'table' then
      cwd = cwd[1]
    end

    ---@diagnostic disable-next-line: missing-fields
    vim.uv.spawn('find', {
      cwd = cwd,
      args = { 'undo', 'swap', 'backup', '-type', 'f', '-mtime', '+' .. days, '-delete' },
    }, function(code, _)
      if code ~= 0 then return end
      vim.notify('Failed to clean up old files. Exit code: ' .. code, vim.log.levels.ERROR)
    end)
  end,
})
