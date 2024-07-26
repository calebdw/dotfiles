local Path = require('plenary.path')
local Job = require('plenary.job')
local util = require('calebdw.util')
local map = util.map

--- Symlink shared files to the worktree.
--- @param root string
--- @param worktree string
--- @return nil
local function symlink_shared_files(root, worktree)
  local shared = root .. '/.shared'
  if not Path:new(shared):exists() then return end
  util.symlink_files(shared, root .. '/' .. worktree, true, true)
end

--- Bootstrap the worktree.
--- @param root string
--- @param worktree string
local bootstrap_worktree = function(root, worktree)
  local bootstrap = root .. '/.bootstrap'
  if not Path:new(bootstrap):exists() then return end
  vim.notify('Bootstrapping worktree: ' .. worktree, vim.log.levels.INFO)

  Job:new({
    command = 'bash',
    args = { bootstrap, worktree },
    cwd = root,
    on_exit = function(j, code)
      if code == 0 then
        vim.notify('Bootstrapping complete: ' .. worktree, vim.log.levels.INFO)
        return
      end
      vim.notify(
        'Error bootstrapping worktree: ' .. worktree .. '\n' .. table.concat(j:stderr_result(), '\n'),
        vim.log.levels.ERROR
      )
    end,
  }):start()
end

--- Serve the worktree.
--- @param root string
--- @param worktree string
local serve_worktree = function(root, worktree)
  local serve = root .. '/.serve'
  if not Path:new(serve):exists() then return end
  vim.notify('Serving worktree: ' .. worktree, vim.log.levels.INFO)

  Job:new({ command = 'rm', args = { '-f', serve }, cwd = root }):sync()

  Job:new({
    command = 'ln',
    args = { '-srfT', worktree, serve },
    cwd = root,
  }):sync()
end

return {
  {
    'NeogitOrg/neogit',
    cmd = { 'Neogit' },
    keys = {
      { '<leader>gs', function() require('neogit').open() end, desc = 'Open Neogit' },
      {
        '<leader>gc',
        function() require('neogit').action('commit', 'commit', { '--verbose' })() end,
        desc = 'Open Neogit',
      },
      {
        '<leader>gp',
        function() require('neogit').action('pull', 'from_upstream')() end,
        desc = 'Neogit pull',
      },
      {
        '<leader>gP',
        function() require('neogit').action('push', 'to_upstream', { '--force-with-lease' })() end,
        desc = 'Neogit push',
      },
      {
        '<leader>gf',
        function() require('neogit').action('fetch', 'fetch_upstream', { '--all', '-p' })() end,
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
        function() require('agitator').git_time_machine({ use_current_win = true }) end,
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
    opts = {},
    config = function(_, opts)
      local gwt = require('git-worktree')
      gwt.setup(opts)
      gwt.on_tree_change(function(op, meta)
        local root = gwt:get_root()
        assert(root, 'Git worktree root not found')
        if op == gwt.Operations.Create then
          symlink_shared_files(root, meta.path)
          serve_worktree(root, meta.path)
          bootstrap_worktree(root, meta.path)
        end
        if op == gwt.Operations.Switch then serve_worktree(root, meta.path) end
      end)

      local telescope = require('telescope')
      telescope.load_extension('git_worktree')
      map({ 'n', 'v' }, '<leader>wc', telescope.extensions.git_worktree.create_git_worktree)
      map({ 'n', 'v' }, '<leader>ww', telescope.extensions.git_worktree.git_worktrees)
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
}
