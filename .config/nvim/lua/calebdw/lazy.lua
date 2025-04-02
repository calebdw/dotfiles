local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

---@type LazyConfig
local opts = {
  checker = { enabled = true, },
  dev = { path = '~/sources/neovim' },
  diff = {
    cmd = 'terminal_git',
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  performance = {
    rtp = { disabled_plugins = { 'netrwPlugin' } },
  },
  ui = { border = 'rounded', },
}

require('lazy').setup('calebdw.plugins', opts)
