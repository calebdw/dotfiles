---@type LazySpec
return {
  'danymat/neogen',
  keys = {
    {
      '<leader>ng',
      function() require('neogen').generate() end,
      desc = 'Generate code annotations',
    },
  },
  opts = {
    snippet_engine = 'luasnip',
  },
  dependencies = 'nvim-treesitter/nvim-treesitter',
}
