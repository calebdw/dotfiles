return {
  'ThePrimeagen/refactoring.nvim',
  -- dir = '~/sources/refactoring.nvim',
  opts = {},
  config = function(_, opts)
    local refactoring = require('refactoring')
    local map = require('user.util').map
    local esc = require('user.util').escape

    refactoring.setup(opts)

    -- Keymaps
    map({ 'x' }, '<leader>rf', [[:lua require('refactoring').refactor('Extract Function')<cr>]])
    map({ 'x' }, '<leader>rF', [[:lua require('refactoring').refactor('Extract Function to File')<cr>]])
    map({ 'x' }, '<leader>rv', [[:lua require('refactoring').refactor('Extract Variable')<cr>]])
    map({ 'x' }, '<leader>ri', [[:lua require('refactoring').refactor('Inline Variable')<cr>]])
    map({ 'n' }, '<leader>rb', [[:lua require('refactoring').refactor('Extract Block')<cr>]])
    map({ 'n' }, '<leader>rB', [[:lua require('refactoring').refactor('Extract Block To File')<cr>]])

    map({ 'x' }, '<leader>rr', function()
      esc()
      refactoring.select_refactor()
    end)
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
