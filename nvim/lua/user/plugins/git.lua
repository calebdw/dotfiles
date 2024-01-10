local map = require('user.util').map

return {
  'tpope/vim-rhubarb',
  {
    'tpope/vim-fugitive',
    config = function()
      map('n', '<leader>Gs', ':Git status<cr>')
      map('n', '<leader>Ga', ':update<cr>:Git add %<cr>')
      map('n', '<leader>GA', ':Git add *<cr>')
      map('n', '<leader>Gb', ':Git branch<cr>')
      map('n', '<leader>GB', ':Git blame<cr>')
      map('n', '<leader>Gc', ':Git commit<cr>')
      map('n', '<leader>Gd', ':Git diff<cr>')
      map('n', '<leader>GC', ':Git commit --amend --no-edit<cr>')
      map('n', '<leader>Gf', ':Git fetch -p<cr>')
      map('n', '<leader>Gl', ':Git log<cr>')
      map('n', '<leader>GL', ':Git reflog<cr>')
      map('n', '<leader>Gp', ':Git pull<cr>')
      map('n', '<leader>GP', ':Git push<cr>')
      map('n', '<leader>Gr', ':Git reset %<cr>')
      map('n', '<leader>GR', ':Git reset<cr>')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = function()
      local gs = require('gitsigns')

      return {
        -- current_line_blame = false
        current_line_blame_opts = {
          virt_text_pos = 'overlay',
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
          Map('n', '<leader>hd', function()
            gs.diffthis('@', { split = 'rightbelow' })
          end)
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
}
