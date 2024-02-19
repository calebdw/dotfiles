return {
  'ellisonleao/glow.nvim',
  ft = 'markdown',
  opts = {
    border = 'rounded',
    pager = false,
    width = 120,
  },
  config = function(_, opts)
    local map = require('user.util').map
    require('glow').setup(opts)

    map('n', '<leader>md', ':w<cr>:Glow<cr>')
  end,
}
