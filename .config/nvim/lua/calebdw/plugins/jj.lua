return {
  'avm99963/vim-jjdescription',
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    opts = {},
  },
  {
    "zschreur/telescope-jj.nvim",
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local map = require('calebdw.util').map

      telescope.load_extension("jj")

      local vcs_conflicts = function(opts)
        local res, _ = pcall(telescope.extensions.jj.conflict, opts)
        if not res then
          builtin.git_commits(opts)
        end
      end
      local vcs_files = function(opts)
        local res, _ = pcall(telescope.extensions.jj.files, opts)
        if not res then
          builtin.git_files(opts)
        end
      end
      local vcs_status = function(opts)
        local res, _ = pcall(telescope.extensions.jj.diff, opts)
        if not res then
          builtin.git_status(opts)
        end
      end

      map({ 'n', 'v' }, '<leader>tc', vcs_conflicts)
      map({ 'n', 'v' }, '<leader>tf', vcs_files)
      map({ 'n', 'v' }, '<leader>ts', vcs_status)
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
}
