return {
  'szw/vim-maximizer', -- zoom
  'nvim-tree/nvim-web-devicons',
  {
    'yamatsum/nvim-nonicons',
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  { 'rcarriga/nvim-notify',  config = true },
  {
    'stevearc/dressing.nvim',
    opts = {
      input = {
        relative = 'editor',
        prefer_width = .4,
      },
    },
  },
  {
    'kosayoda/nvim-lightbulb',
    opts = { autocmd = { enabled = true } },
  },
  { -- Pretty List
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = true,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'auto',
        globalstatus = true,
      },
      extensions = {
        'fugitive',
        'fzf',
        'man',
        -- 'nvim-dap-ui',
        'nvim-tree',
        'quickfix',
        'toggleterm',
      }
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/tokyonight.nvim',
      'marko-cerovac/material.nvim',
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },
  { -- Fancy Start Page
    'startup-nvim/startup.nvim',
    enabled = false,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      theme = 'evil',
    },
  },
  -- Smooth Scrolling --
  { 'karb94/neoscroll.nvim', config = true },
  -- Dim Inactive Codeblocks --
  { 'folke/twilight.nvim',   config = true },
  -- Zen Mode --
  { 'folke/zen-mode.nvim',   config = true },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      hide_inactive_statusline = true,
      on_highlights = function(highlights, colors)
        -- highlights['@variable'].fg = '#ffb777'
      end,
      sidebars = {
        'help',
        'packer',
        'qf',
        'terminal',
        'vista_kind',
      },
      style = 'night',
      terminal_colors = true,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end,
  },
  {
    'marko-cerovac/material.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      lualine_style = 'default',
      contrast = {
        terminal = true,
        sidebars = true,
        floating_windows = true,
        non_current_windows = false,
      },
      plugins = {
        'dap',
        'gitsigns',
        'indent-blankline',
        'lspsaga',
        'nvim-cmp',
        'nvim-web-devicons',
        'telescope',
        'trouble',
      },
    },
    config = function(_, opts)
      vim.g.material_style = 'deep ocean'
      require('material').setup(opts)
      vim.cmd.colorscheme('material')
    end,
  },
  { -- colorize colors
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        css = true,
        names = false,
        mode = 'background',
        tailwind = 'lsp',
      }
    },
  },
}
