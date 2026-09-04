local util = require('calebdw.util')

---@type LazySpec
return {
  {
    'nvim-neotest/neotest',
    keys = {
      { '<leader>rt', function() require('neotest').run.run() end, desc = 'Run test' },
      { '<leader>rd', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Run test with dap' },
      { '<leader>ra', function() require('neotest').run.attach() end, desc = 'Attach to test' },
      { '<leader>rs', function() require('neotest').run.stop() end, desc = 'Stop test' },
      { '<leader>rf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run test file' },
      { '<leader>rS', function() require('neotest').run.run({ suite = true }) end, desc = 'Run test suite' },
      { '<leader>ro', function() require('neotest').output() end, desc = 'Open test output' },
      { '<leader>pt', ':TestFile<cr>', desc = 'Run test file (vim-test)' },
      { '<leader>pT', ':w<cr>:TestFile<cr>', desc = 'Save and run test file (vim-test)' },
    },
    opts = function()
      return {
        discovery = {
          enabled = false,
        },
        adapters = {
          -- require('neotest-phpunit')({
          --   phpunit_cmd = function() return util.sail('phpunit') end,
          -- }),
          require('neotest-pest')({
            sail_project_path = '/var/www/html',
          }),
          require('neotest-plenary'),
          require('neotest-vitest'),
          -- this caused neotest to fail
          -- require('neotest-playwright'),
          require('neotest-vim-test')({
            allow_file_types = { 'php' },
          }),
          require("neotest-rust"),
        },
        -- log_level = vim.log.levels.INFO,
      }
    end,
    init = function()
      vim.g['test#strategy'] = 'toggleterm'
      vim.g['test#php#pest#executable'] = util.sail_or_bin('pest', true)
    end,
    dependencies = {
      -- deps
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      -- Adapters
      'vim-test/vim-test',
      'nvim-neotest/neotest-vim-test',
      'olimorris/neotest-phpunit',
      'thenbe/neotest-playwright',
      { 'V13Axel/neotest-pest', branch = 'PHPUnit_Test_Support' },
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-plenary',
      'rouge8/neotest-rust',
    },
  },
}
