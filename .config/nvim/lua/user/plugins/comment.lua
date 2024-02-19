vim.g.skip_ts_context_commentstring_module = true

return {
  {
    'numToStr/Comment.nvim',
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        ignore = '^$', -- ignores empty lines
      }
    end,
    config = function(_, opts)
      require('Comment').setup(opts)

      local ft = require('Comment.ft')
      ft.set('blade', { '{{-- %s --}}', '{{-- %s --}}' })
      ft.set('antlers', { '{{# %s #}}', '{{# %s #}}' })
    end,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = { enable_autocmd = false },
  },
}
