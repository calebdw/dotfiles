local map = require('calebdw.util').map

local parsers = {
  'bash',
  'blade',
  'c',
  'comment',
  'cpp',
  'css',
  'csv',
  'dap_repl',
  'devicetree',
  'diff',
  'ebnf',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'go',
  'html',
  'ini',
  'javascript',
  'json',
  'json5',
  'jsonc',
  'jsdoc',
  'latex',
  'lua',
  'luadoc',
  'make',
  'markdown',
  'markdown_inline',
  'mermaid',
  'ocaml',
  'passwd',
  'php',
  'php_only',
  'phpdoc',
  'query',
  'regex',
  'rust',
  'sql',
  'ssh_config',
  'toml',
  'twig',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}

---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    opts = {},
    config = function(_, opts)
      local nts = require('nvim-treesitter')

      vim.api.nvim_create_autocmd('FileType', {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          local configs = require('nvim-treesitter.parsers')

          -- configs.blade.install_info = {
          --   path = '~/sources/treesitter/tree-sitter-blade',
          --   generate = true,
          --   generate_from_json = true,
          -- }

          -- configs.phpdoc.install_info = {
          --   path = '~/sources/treesitter/tree-sitter-phpdoc',
          --   generate = true,
          --   generate_from_json = true,
          -- }

          -- configs.php.install_info = {
          --   path = '~/sources/treesitter/tree-sitter-php',
          --   location = 'php',
          --   generate = true,
          --   generate_from_json = true,
          -- }

          -- configs.php_only.install_info = {
          --   path = '~/sources/treesitter/tree-sitter-php',
          --   location = 'php_only',
          --   generate = true,
          --   generate_from_json = true,
          -- }
        end,
      })

      nts.setup(opts)
      nts.install(parsers)

      map('n', '<leader>it', vim.treesitter.inspect_tree)
      map('n', '<leader>i', vim.show_pos)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    opts = {
      select = {
        lookahead = true,
        -- keymaps = {
        --   ['if'] = '@function.inner',
        --   ['af'] = '@function.outer',
        --   ['ic'] = '@class.inner',
        --   ['ac'] = '@class.outer',
        --   ['il'] = '@loop.inner',
        --   ['al'] = '@loop.outer',
        --   ['ia'] = '@parameter.inner',
        --   ['aa'] = '@parameter.outer',
        -- },
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    enabled = false, -- this breaks dot repeating with `>`
    opts = {
      enable_close_on_slash = true,
    },
  },
}
