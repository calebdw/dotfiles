local map = require('user.util').map

return {
  -- Neotest is not working right now so reverting back to vim-test
  ---@todo: remove once neotest is working
  {
    'vim-test/vim-test',
    config = function()
      vim.g['test#custom_strategies'] = {
        toggleterm = function(cmd)
          require('toggleterm').exec(cmd)
        end,
      }
      vim.g['test#strategy'] = 'toggleterm'
      vim.g['test#php#pest#executable'] = './vendor/bin/sail test'

      map('n', '<leader>pt', function()
        vim.cmd.write()
        vim.cmd('TestNearest')
      end)
      map('n', '<leader>pf', function()
        vim.cmd.write()
        vim.cmd('TestFile')
      end)
    end,
  },
  {
    'nvim-neotest/neotest',
    enabled = false,
    dependencies = {
      'vim-test/vim-test',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- 'olimorris/neotest-phpunit',
      'theutz/neotest-pest',
      'nvim-neotest/neotest-plenary',
      'antoinemadec/FixCursorHold.nvim',
    },
    opts = function()
      return {
        discovery = {
            enabled = false,
        },
        adapters = {
            -- require('neotest-phpunit'),
            require('neotest-pest'),
            -- require('neotest-pest')({
            --     pest_cmd = function()
            --         return 'vendor/bin/sail bin pest'
            --     end,
            -- }),
            require('neotest-plenary'),
        },
        log_level = 1,
      }
    end,
    config = function(_, opts)
      local neotest = require('neotest')

      neotest.setup(opts)

      map('n', '<leader>pt', neotest.run.run)
      map('n', '<leader>pa', neotest.run.attach)
      map('n', '<leader>ps', neotest.run.stop)
      map('n', '<leader>pf', function()
        neotest.run.run(vim.fn.expand('%'))
      end)
      map('n', '<leader>pS', function() neotest.run.run({ suite = true }) end)
    end,
  },
}
