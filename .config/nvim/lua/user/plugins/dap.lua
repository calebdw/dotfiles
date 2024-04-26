local map = require('user.util').map

return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      local widgets = require('dap.ui.widgets')

      dap.adapters.php = {
        type = 'executable',
        command = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/php-debug-adapter/php-debug-adapter',
      }

      dap.configurations.php = {
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug in Docker',
          pathMappings = {
            ['/var/www'] = '${workspaceFolder}',
          },
          repl_lang = 'php_only',
        },
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug locally',
          repl_lang = 'php_only',
        },
      }

      map('n', '<F5>', function() dap.continue() end)
      map('n', '<F10>', function() dap.step_over() end)
      map('n', '<F11>', function() dap.step_into() end)
      map('n', '<F12>', function() dap.step_out() end)
      map('n', '<leader>b', function() dap.toggle_breakpoint() end)
      map('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
      map('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
      map('n', '<leader>dr', function() dap.repl.open() end)
      map('n', '<leader>dl', function() dap.run_last() end)
      map({'n', 'v'}, '<leader>dh', function() widgets.hover() end)
      map({'n', 'v'}, '<leader>dp', function() widgets.preview() end)
      map('n', '<leader>ds', function() widgets.centered_float(widgets.scopes) end)

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '' })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '' })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '' })

      vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='', numhl= '' })
      vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='', numhl= '' })
      vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='debugPC', numhl= '' })
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    opts = {},
    config = function(_, opts)
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup(opts)

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    opts = {},
  },
  {
    'LiadOz/nvim-dap-repl-highlights',
    opts = {},
  }
}
