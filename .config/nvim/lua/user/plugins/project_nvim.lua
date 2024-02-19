return {
  'ahmedkhalf/project.nvim',
  name = 'project_nvim',
  opts = {
    detection_methods = { 'pattern' },
    -- only create projects in git repos
    patterns = { '.git' },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
}
