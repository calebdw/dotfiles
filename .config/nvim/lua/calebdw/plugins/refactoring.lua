---@type LazySpec
return {
  'ThePrimeagen/refactoring.nvim',
  keys = {
    {
      '<leader>rf',
      function() require('refactoring').refactor('Extract Function') end,
      mode = 'x',
      desc = 'Extract Function',
    },
    {
      '<leader>rF',
      function() require('refactoring').refactor('Extract Function to File') end,
      mode = 'x',
      desc = 'Extract Function to File',
    },
    {
      '<leader>rv',
      function() require('refactoring').refactor('Extract Variable') end,
      mode = 'x',
      desc = 'Extract Variable',
    },
    {
      '<leader>ri',
      function() require('refactoring').refactor('Inline Variable') end,
      mode = 'x',
      desc = 'Inline Variable',
    },
    {
      '<leader>rb',
      function() require('refactoring').refactor('Extract Block') end,
      desc = 'Extract Block',
    },
    {
      '<leader>rB',
      function() require('refactoring').refactor('Extract Block To File') end,
      desc = 'Extract Block To File',
    },
    {
      '<leader>rr',
      function()
        require('calebdw.util').escape()
        require('refactoring').select_refactor()
      end,
      mode = 'x',
      desc = 'Select Refactor',
    },
  },
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
