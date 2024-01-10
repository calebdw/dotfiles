return {
  -- 'folke/neoconf.nvim', -- global / local config
  'folke/neodev.nvim', -- neovim api docs
  opts = {
    library = {
      plugins = {
        -- Neotest unused for now
        -- 'neotest',
        'nvim-dap-ui',
      },
      types = true,
    }
  },
}
