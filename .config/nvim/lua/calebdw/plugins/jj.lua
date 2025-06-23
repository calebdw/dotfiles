local map = require('calebdw.util').map

---@type LazySpec
return {
  'avm99963/vim-jjdescription',
  {
    'julienvincent/hunk.nvim',
    cmd = 'DiffEditor',
    opts = {},
  },
  {
    'algmyr/vcsigns.nvim',
    opts = {
      target_commit = 1,  -- Nice default for jj with new+squash flow.
      signs = {
        change_delete = { text = '~' },
      },
    },
    init = function()
      local actions = require('vcsigns.actions')
      local colors = require('tokyonight.colors').setup()

      vim.api.nvim_set_hl(0, 'SignAdd', { fg = colors.git.add })
      vim.api.nvim_set_hl(0, 'SignChange', { fg = colors.git.change })
      vim.api.nvim_set_hl(0, 'SignDelete', { fg = colors.git.delete })

      map('n', '[r', function() actions.target_older_commit(0, vim.v.count1) end, { desc = 'Move diff target back' })
      map('n', ']r', function() actions.target_newer_commit(0, vim.v.count1) end, { desc = 'Move diff target forward' })
      map('n', '[h', function() actions.hunk_prev(0, vim.v.count1) end, { desc = 'Go to previous hunk' })
      map('n', ']h', function() actions.hunk_next(0, vim.v.count1) end, { desc = 'Go to next hunk' })
      map('n', '[H', function() actions.hunk_prev(0, 9999) end, { desc = 'Go to first hunk' })
      map('n', ']H', function() actions.hunk_next(0, 9999) end, { desc = 'Go to last hunk' })
      map({ 'n', 'v' }, '<leader>hr', function() actions.hunk_undo(0) end, { desc = 'Undo the hunk under the cursor' })
      map('n', '<leader>hR', function() actions.hunk_undo(0, { 0, vim.fn.line('$') }) end, { desc = 'Undo the hunks in the file' })
      map('n', '<leader>hd', function() actions.toggle_hunk_diff(0) end, { desc = 'Show diff of hunk under the cursor' })
    end,
    dependencies = {
      'algmyr/vclib.nvim',
    },
  },
  {
    'zschreur/telescope-jj.nvim',
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')

      telescope.load_extension("jj")

      local vcs_conflicts = function(opts)
        local res, _ = pcall(telescope.extensions.jj.conflicts, opts)
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
      'nvim-telescope/telescope.nvim',
    },
  },
}
