return {
  'ahmedkhalf/project.nvim',
  name = 'project_nvim',
  opts = {
    detection_methods = { 'pattern' },
    -- only create projects in git repos
    patterns = { '.git' },
  },
  init = function()
    local telescope = require('telescope')
    local map = require('calebdw.util').map

    telescope.load_extension('projects')
    map({ 'n', 'v' }, '<leader>tp', telescope.extensions.projects.projects)
  end,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
}
