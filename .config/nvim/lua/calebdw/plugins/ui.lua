return {
  {
    'szw/vim-maximizer',
    cmd = 'MaximizerToggle',
    keys = {
      { '<F3>', mode = { 'n', 'i', 'v' } },
    },
  },
  'nvim-tree/nvim-web-devicons',
  {
    'yamatsum/nvim-nonicons',
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  {
    'rcarriga/nvim-notify',
    config = true,
    init = function()
      local telescope = require('telescope')
      local map = require('calebdw.util').map
      vim.notify = require('notify')

      telescope.load_extension('notify')
      map({ 'n', 'v' }, '<leader>Tn', telescope.extensions.notify.notify)
    end,
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
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
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = {
      wezterm = {
        enabled = true,
      },
    },
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      hide_inactive_statusline = true,
      -- on_highlights = function(highlights, colors)
      --   highlights['@variable'].fg = '#ffb777'
      -- end,
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
  {
    'ziontee113/icon-picker.nvim',
    cmd = { 'IconPickerNormal', 'IconPickerInsert', 'IconPickerYank' },
    opts = {},
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = false,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      'hrsh7th/nvim-cmp',
    },
  },
}
