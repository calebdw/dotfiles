return {
  {
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
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
