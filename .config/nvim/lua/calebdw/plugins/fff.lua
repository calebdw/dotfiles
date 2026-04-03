---@type LazySpec
return {
  'dmtrKovalenko/fff.nvim',
  build = function() require('fff.download').download_or_build_binary() end,
  opts = {
    debug = {
      enabled = true, -- we expect your collaboration at least during the beta
      show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
    },
    preview = {
      line_numbers = true,
    },
  },
  lazy = false,
  keys = {
    {
      'ff',
      function() require('fff').find_files() end,
      desc = 'FFFind files',
    },
    {
      'fg',
      function() require('fff').live_grep() end,
      desc = 'LiFFFe grep',
    },
    {
      'fz',
      function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end,
      desc = 'Live fffuzy grep',
    },
    {
      'fc',
      function() require('fff').live_grep({ query = vim.fn.expand('<cword>') }) end,
      desc = 'Search current word',
    },
  },
}
