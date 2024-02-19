return {
  'L3MON4D3/LuaSnip',
  build = 'make install_jsregexp',
  opts = {
    enable_autosnippets = false,
    history = true,
    delete_check_events = 'TextChanged',
    update_events = {'TextChanged', 'TextChangedI'},
    -- @todo: Set ft using treesitter
  },
  config = function(_, opts)
    local ls = require('luasnip')
    local map = require('user.util').map

    ls.setup(opts)

    -- `honza/vim-snippets` '_' contains global snips
    ls.filetype_extend('all', { '_' })

    require('luasnip.loaders.from_snipmate').lazy_load()
    require('luasnip.loaders.from_lua').load()

    -- Keymaps
    map({ 'i', 's' }, '<c-k>', function()
      -- You could replace the expand_or_jumpable() calls with
      -- expand_or_locally_jumpable() that way you will only jump
      -- inside the snippet region
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end)

    map({ 'i', 's' }, '<c-j>', function()
      if ls.jumpable( -1) then
        ls.jump( -1)
      end
    end)

    map('i', '<c-l>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    -- Commands
    vim.api.nvim_create_user_command(
      'LuaSnipEdit',
      require('luasnip.loaders').edit_snippet_files,
      {}
    )

    vim.api.nvim_create_user_command('LuaSnipReload', function()
      require('luasnip.loaders.from_snipmate').lazy_load()
      require('luasnip.loaders.from_lua').load()
    end, {})
  end,
  dependencies = {
    'honza/vim-snippets',
  },
}
