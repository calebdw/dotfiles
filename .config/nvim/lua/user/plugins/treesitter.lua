return {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  opts = {
    ensure_installed = 'all',
    highlight = {
      enable = true,
      -- disable = {"javascript", "typescript"},
      -- additional_vim_regex_highlighting = true,
    },
    -- Needed because treesitter highlight turns off autoindent for php files
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        -- set to `false` to disable one of the mappings
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    autotag = { -- 'windwp/nvim-ts-autotag'
      enable = true,
    },
    endwise = { -- 'RRethy/nvim-treesitter-endwise',
      enable = true,
    },
    -- 'nvim-treesitter/playground',
    playground = {
      enable = true,
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { 'BufWrite', 'CursorHold' },
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
    context_commentstring = { -- JoosepAlviste/nvim-ts-context-commentstring
      enable = true,
      enable_autocmd = false, -- using Comment.nvim
    },
  },
  config = function(_, opts)
    local map = require('user.util').map
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
    --     branch = "master",
    --     generate_requires_npm = true,
    --     requires_generate_from_grammar = true,
    --   },
    --   filetype = 'php',
    -- }

    -- parser_config.php_only = {
    --   install_info = {
    --     url = '~/sources/treesitter/tree-sitter-php/tree-sitter-php-only',
    --     files = {
    --       'src/parser.c',
    --       'src/scanner.c',
    --     },
    --     branch = "split_parsers",
    --     generate_requires_npm = false,
    --     requires_generate_from_grammar = false,
    --   },
    --   -- filetype = 'php',
    -- }

    require('nvim-treesitter.configs').setup(opts)

    map('n', '<leader>pg', '<cmd>TSPlayground<cr>')
    map('n', '<leader>ph', '<cmd>TSHighlightCapturesUnderCursor<cr>')
    map('n', '<leader>pn', '<cmd>TSNodeUnderCursor<cr>')
  end,
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'windwp/nvim-ts-autotag',
    'RRethy/nvim-treesitter-endwise',
    -- @todo: configure plugin
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/playground',
  },
}
