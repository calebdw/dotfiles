local map = require('calebdw.util').map

return {
  {
    'NeogitOrg/neogit',
    cmd = { 'Neogit' },
    keys = {
      {'<leader>Gs', function() require('neogit').open() end, desc = 'Open Neogit', },
      {
        '<leader>Gc',
        function()
          require('neogit').action('commit', 'commit', { '--verbose' })()
        end,
        desc = 'Open Neogit',
      },
      {
        '<leader>Gp',
        function()
          require('neogit').action('pull', 'from_upstream')()
        end,
        desc = 'Neogit pull',
      },
      {
        '<leader>GP',
        function()
          require('neogit').action('push', 'to_upstream', { '--force-with-lease', })()
        end,
        desc = 'Neogit push',
      },
      {
        '<leader>Gf',
        function()
          require('neogit').action('fetch', 'fetch_upstream', { '--all', '-p', })()
        end,
        desc = 'Neogit fetch',
      },
    },
    opts = {
      graph_style = 'unicode',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'FabijanZulj/blame.nvim',
    cmd = { 'BlameToggle' },
    opts = {
      date_format = '%Y-%m-%d',
    },
  },
  {
    'emmanueltouzery/agitator.nvim',
    keys = {
      {
        '<leader>Gbt',
        function() require('agitator').git_blame_toggle() end,
        desc = 'Git blame toggle',
      },
      {
        '<leader>Gbm',
        function()
          require('agitator').git_time_machine({ use_current_win = true })
        end,
        desc = 'Git blame time machine',
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = function()
      local gs = require('gitsigns')

      return {
        -- current_line_blame = false
        current_line_blame_opts = {
          virt_text_pos = 'eol',
        },
        preview_config = {
          border = 'rounded',
        },
        on_attach = function(bufnr)
          local function Map(m, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            map(m, l, r, opts)
          end

          -- Navigation
          Map('n', ']h', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          Map('n', '[h', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          Map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk)
          Map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk)
          Map('n', '<leader>hu', gs.undo_stage_hunk)
          Map('n', '<leader>hS', gs.stage_buffer)
          Map('n', '<leader>hR', gs.reset_buffer)
          Map('n', '<leader>hp', gs.preview_hunk)
          Map('n', '<leader>hb', function() gs.blame_line({ full = true }) end)
          Map('n', '<leader>hd', function() gs.diffthis('@', { split = 'rightbelow' }) end)
          Map('n', '<leader>hD', function() gs.diffthis('~') end)
          Map('n', '<leader>td', gs.toggle_deleted)
          Map('n', '<leader>tw', gs.toggle_word_diff)
          Map('n', '<leader>tb', gs.toggle_current_line_blame)

          -- Text object
          Map({ 'o', 'x' }, 'ih', gs.select_hunk)
        end,
      }
    end,
  },
  {
    'calebdw/git-worktree.nvim',
    branch = 'main',
    opts = {},
    init = function()
      local telescope = require('telescope')
      local extensions = telescope.extensions

      telescope.load_extension('git_worktree')

      map({ 'n', 'v' }, '<leader>gc', extensions.git_worktree.create_git_worktree)
      map({ 'n', 'v' }, '<leader>gw', extensions.git_worktree.git_worktrees)
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    }
  },
}
