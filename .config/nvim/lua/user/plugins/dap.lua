return {
  -- @todo configure debug adapters
  {
    'mfussenegger/nvim-dap',
  },
  'theHamsta/nvim-dap-virtual-text', -- virtual text support
  {
    'rcarriga/nvim-dap-ui',
    opts = {},
    config = function(_, opts)
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup(opts)

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
    dependencies = 'mfussenegger/nvim-dap',
  },
  'nvim-telescope/telescope-dap.nvim',
  'rcarriga/cmp-dap',
}
