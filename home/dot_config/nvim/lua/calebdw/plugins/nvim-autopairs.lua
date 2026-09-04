---@type LazySpec
return {
  'windwp/nvim-autopairs',
  opts = {
    check_ts = true,
    enable_check_bracket_line = true,
    fast_wrap = {},
  },
  config = function(_, opts)
    local npairs = require('nvim-autopairs')
    local rule = require('nvim-autopairs.rule')

    npairs.setup(opts)

    -- add spaces to brackets
    npairs.add_rules({
      rule(' ', ' ')
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ '()', '[]', '{}' }, pair)
      end),
      rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
      rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
      rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
    })
  end,
}
