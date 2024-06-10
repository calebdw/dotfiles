return {
  'olimorris/persisted.nvim',
  opts = {
    use_git_branch = true,
    autoload = true,
    autosave = true,
    branch_separator = '@@',
  },
  init = function()
    local telescope = require('telescope')
    local map = require('calebdw.util').map

    telescope.load_extension('persisted')
    map({ 'n', 'v' }, '<leader>tP', telescope.extensions.persisted.persisted)
  end,
  dependencies = { 'nvim-telescope/telescope.nvim' },
}
