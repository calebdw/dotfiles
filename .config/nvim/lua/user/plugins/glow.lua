return {
  'ellisonleao/glow.nvim',
  keys = {
    {
      '<leader>md',
      ':w<cr>:Glow<cr>',
      desc = 'Render markdown',
    },
  },
  opts = {
    border = 'rounded',
    pager = false,
    width = 120,
  },
}
