return {
  'nvim-treesitter/nvim-treesitter',
  build = function() require('nvim-treesitter.install').update({ with_sync = true })() end,
  opts = {
    ensure_installed = {
      'blade',
      'c',
      'css',
      'html',
      'javascript',
      'lua',
      'markdown',
      'markdown_inline',
      'php',
      'php_only',
      'phpdoc',
      'query',
      'sql',
      'vim',
      'vimdoc',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = { -- set to `false` to disable one of the mappings
        init_selection = 'gnn',
        node_incremental = 'grn',
        scope_incremental = 'grc',
        node_decremental = 'grm',
      },
    },
    autotag = { -- 'windwp/nvim-ts-autotag'
      enable = false, -- this breaks dot repeating with `>`
    },
    endwise = { -- 'RRethy/nvim-treesitter-endwise',
      enable = true,
    },
    textobjects = { -- 'nvim-treesitter/nvim-treesitter-textobjects',
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['if'] = '@function.inner',
          ['af'] = '@function.outer',
          ['ic'] = '@class.inner',
          ['ac'] = '@class.outer',
          ['il'] = '@loop.inner',
          ['al'] = '@loop.outer',
          ['ia'] = '@parameter.inner',
          ['aa'] = '@parameter.outer',
        },
      },
    },
  },
  config = function(_, opts)
    local map = require('calebdw.util').map
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

    parser_config.blade = {
      install_info = {
        url = '~/sources/treesitter/tree-sitter-blade',
        files = {
          'src/parser.c',
          -- 'src/scanner.cc',
        },
        generate_requires_npm = true,
        requires_generate_from_grammar = true,
      },
      filetype = 'blade',
    }

    -- parser_config.phpdoc = {
    --   install_info = {
    --     url = '~/sources/treesitter/tree-sitter-phpdoc',
    --     files = {
    --       'src/parser.c',
    --       'src/scanner.c',
    --     },
    --     branch = "master",
    --     generate_requires_npm = true,
    --     requires_generate_from_grammar = true,
    --   },
    --   filetype = 'php',
    -- }

    -- parser_config.php = {
    --   install_info = {
    --     url = '~/sources/treesitter/tree-sitter-php/php',
    --     files = {
    --       'src/parser.c',
    --       'src/scanner.c',
    --     },
    --     branch = 'master',
    --     generate_requires_npm = false,
    --     requires_generate_from_grammar = false,
    --   },
    --   filetype = 'php',
    -- }
    --
    -- parser_config.php_only = {
    --   install_info = {
    --     url = '~/sources/treesitter/tree-sitter-php/php_only',
    --     files = {
    --       'src/parser.c',
    --       'src/scanner.c',
    --     },
    --     branch = 'master',
    --     generate_requires_npm = false,
    --     requires_generate_from_grammar = false,
    --   },
    --   -- filetype = 'php',
    -- }

    require('nvim-treesitter.configs').setup(opts)

    map('n', '<leader>it', vim.treesitter.inspect_tree)
    map('n', '<leader>i', vim.show_pos)
  end,
  dependencies = {
    'windwp/nvim-ts-autotag',
    'RRethy/nvim-treesitter-endwise',
    -- @todo: configure plugin
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'LiadOz/nvim-dap-repl-highlights',
  },
}
