---@type LazySpec
return {
  'ThePrimeagen/refactoring.nvim',
  -- keys = {
  --   {
  --     '<leader>rf',
  --     function() return require('refactoring').refactor('Extract Function') end,
  --     mode = { 'n', 'x' },
  --     desc = 'Extract Function',
  --     expr = true,
  --   },
  --   {
  --     '<leader>rF',
  --     function() return require('refactoring').refactor('Extract Function to File') end,
  --     mode = { 'n', 'x' },
  --     desc = 'Extract Function to File',
  --     expr = true,
  --   },
  --   {
  --     '<leader>rv',
  --     function() return require('refactoring').refactor('Extract Variable') end,
  --     mode = { 'n', 'x' },
  --     desc = 'Extract Variable',
  --     expr = true,
  --   },
  --   {
  --     '<leader>ri',
  --     function() return require('refactoring').refactor('Inline Variable') end,
  --     mode = { 'n', 'x' },
  --     desc = 'Inline Variable',
  --     expr = true,
  --   },
  --   {
  --     '<leader>rb',
  --     function() return require('refactoring').refactor('Extract Block') end,
  --     mode = { 'n', 'x' },
  --     desc = 'Extract Block',
  --     expr = true,
  --   },
  --   {
  --     '<leader>rB',
  --     function() return require('refactoring').refactor('Extract Block To File') end,
  --     mode = { 'n', 'x' },
  --     desc = 'Extract Block To File',
  --     expr = true,
  --   },
  --   {
  --     '<leader>rr',
  --     function()
  --       require('calebdw.util').escape()
  --       require('refactoring').select_refactor()
  --     end,
  --     mode = { 'n', 'x' },
  --     desc = 'Select Refactor',
  --   },
  -- },
  lazy = false,
  opts = {},
  init = function()
    local map = require('calebdw.util').map
    local ref = require('refactoring')

    local Map = function(m, l, r, desc)
      map(m, l, r, { desc = desc, expr = true })
    end

    Map({ 'n', 'x' }, '<leader>rf', function() return ref.refactor('Extract Function') end, 'Extract Function')
    Map({ 'n', 'x' }, '<leader>rF', function() return ref.refactor('Extract Function to File') end, 'Extract Function to File')
    Map({ 'n', 'x' }, '<leader>rv', function() return ref.refactor('Extract Variable') end, 'Extract Variable')
    Map({ 'n', 'x' }, '<leader>ri', function() return ref.refactor('Inline Variable') end, 'Inline Variable')
    Map({ 'n', 'x' }, '<leader>rb', function() return ref.refactor('Extract Block') end, 'Extract Block')
    Map({ 'n', 'x' }, '<leader>rB', function() return ref.refactor('Extract Block To File') end, 'Extract Block To File')
    Map({ 'n', 'x' }, '<leader>rr', function()
      require('calebdw.util').escape()
      ref.select_refactor()
    end, 'Select Refactor')
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
