--[[
    Use `vim.pretty_print(table)` to show tables,
    can also use `=table` to show tables
--]]

require('user.autocommands')
require('user.settings')
require('user.mappings')

-- Bootstrap Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('user.plugins', {
  performance = {
    rtp = {
      disabled_plugins = {
        'netrwPlugin',
      },
    },
  },
  ui = {
    border = 'rounded',
  },
})
