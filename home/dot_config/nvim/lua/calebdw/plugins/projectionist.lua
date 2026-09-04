---@type LazySpec
return {
  'tpope/vim-projectionist',
  config = function()
    vim.g['projectionist_heuristics'] = {
      artisan = {
        ['*'] = {
          start = 'sail up -d',
          console = 'sail tinker',
        },
      },
    }
  end,
}
