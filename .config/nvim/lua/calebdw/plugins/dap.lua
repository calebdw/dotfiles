local map = require('calebdw.util').map

return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      local widgets = require('dap.ui.widgets')
      local registry = require('mason-registry')

      -- dap.set_log_level('TRACE')

      dap.configurations.javascript = {
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach debugger to existing `node --inspect` process',
          cwd = '${workspaceFolder}',
          skipFiles = {
            '${workspaceFolder}/node_modules/**/*.js',
            '${workspaceFolder}/packages/**/node_modules/**/*.js',
            '${workspaceFolder}/packages/**/**/node_modules/**/*.js',
            '<node_internals>/**',
            'node_modules/**',
          },
          sourceMaps = true,
          console = 'integratedTerminal',
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch browser to debug client side code',
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = 'Enter URL: ', default = 'http://localhost:5173' }, function(url)
                if url == nil or url == '' then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          runtimeExecutable = '/usr/bin/brave-browser',
          -- for TypeScript/Svelte
          sourceMaps = true,
          webRoot = '${workspaceFolder}/src',
          protocol = 'inspector',
          port = 9222,
          -- skip files from vite's hmr
          skipFiles = { '**/node_modules/**/*', '**/@vite/*', '**/src/client/*', '**/src/*' },
        },
      }

      dap.adapters.php = {
        type = 'executable',
        command = registry.get_package('php-debug-adapter'):get_install_path() .. '/php-debug-adapter',
      }
      dap.configurations.php = {
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug in Docker',
          pathMappings = {
            ['/var/www/html'] = '${workspaceFolder}',
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
      map({ 'n', 'v' }, '<leader>dh', function() widgets.hover() end)
      map({ 'n', 'v' }, '<leader>dp', function() widgets.preview() end)
      map('n', '<leader>ds', function() widgets.centered_float(widgets.scopes) end)

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '' })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '' })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '' })

      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'debugPC', numhl = '' })
    end,
  },
  {
    'mxsdev/nvim-dap-vscode-js',
    opts = {
      debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    },
    dependencies = { 'mfussenegger/nvim-dap' },
  },
  {
    'rcarriga/nvim-dap-ui',
    opts = {},
    config = function(_, opts)
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup(opts)

      local open = function() dapui.open() end

      local close = function() dapui.close() end

      map('n', '<leader>dt', function() dapui.toggle() end)

      dap.listeners.before.attach.dapui_config = open
      dap.listeners.before.launch.dapui_config = open
      dap.listeners.before.disconnect.dapui_config = close
      dap.listeners.before.event_terminated.dapui_config = close
      dap.listeners.before.event_exited.dapui_config = close
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
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    init = function()
      local telescope = require('telescope')

      telescope.load_extension('dap')
      map({ 'n', 'v' }, '<leader>dc', telescope.extensions.dap.commands)
      map({ 'n', 'v' }, '<leader>dC', telescope.extensions.dap.configurations)
      map({ 'n', 'v' }, '<leader>db', telescope.extensions.dap.list_breakpoints)
      map({ 'n', 'v' }, '<leader>dv', telescope.extensions.dap.variables)
      map({ 'n', 'v' }, '<leader>df', telescope.extensions.dap.frames)
    end,
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-telescope/telescope.nvim',
    },
  },
}
