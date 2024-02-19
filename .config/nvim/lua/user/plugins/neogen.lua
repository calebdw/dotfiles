return {
  'danymat/neogen',
  opts = {
    snippet_engine = 'luasnip',
  },
  config = function(_, opts)
    local neogen = require('neogen')
    local map = require('user.util').map

    neogen.setup(opts)

    map('n', '<leader>ng', neogen.generate)
  end,
  dependencies = 'nvim-treesitter/nvim-treesitter',
}
