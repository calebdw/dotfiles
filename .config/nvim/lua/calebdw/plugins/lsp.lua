local map = require('calebdw.util').map

-- vim.lsp.set_log_level('debug')
vim.lsp.config('*', {
  handlers = {
    -- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips#use-nvim-notify-to-display-lsp-messages
    ['window/showMessage'] = function(err, result, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if client == nil then return end
      local lvl = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]
      vim.notify(result.message, vim.lsp.log_levels[result.type], {
        title = 'LSP | ' .. client.name,
        timeout = 10000,
      })
    end,
  },
  on_attach = function(client, bufnr)
    local opts = { client_id = client, bufnr = bufnr }

    vim.lsp.codelens.enable(true, opts)
    vim.lsp.inlay_hint.enable(true, opts)
    vim.lsp.linked_editing_range.enable(true, opts)

    opts = { buf = bufnr }
    map('n', '<leader>gD', vim.lsp.buf.declaration, opts)
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    map('n', '<leader>wl', function() vim.print(vim.lsp.buf.list_workspace_folders()) end, opts)
  end,
})

-- Default servers to install
---@type table<string, function|vim.lsp.Config>
local servers = {
  ansiblels = {
    filetypes = {
      'antlers.html',
      'antlers',
      'html',
    },
  },
  antlersls = {}, -- Statamic/Antlers
  cmake = {},
  clangd = {}, -- C++
  cssls = {},
  cssmodules_ls = {},
  dockerls = {},
  emmet_ls = {
    filetypes = {
      'antlers.html',
      'antlers',
      'blade.html.php',
      'blade',
      'html',
      'css',
      'sass',
      'scss',
    },
  },
  html = {
    filetypes = {
      'antlers.html',
      'antlers',
      'blade.html.php',
      'blade',
      'html',
    },
  },
  jsonls = function()
    return {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = {
            enable = true,
          },
        },
      },
    }
  end,
  lemminx = {}, -- XM
  lua_ls = function()
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    return {
      settings = {
        Lua = {
          diagnostics = {
            -- luasnip globals
            globals = { 'ls', 's', 'sn', 'isn', 'c', 'i', 'd', 't', 'f', 'r', 'fmt', 'fmta' },
          },
          runtime = { version = 'LuaJIT', path = runtime_path },
          workspace = {
            checkThirdParty = false,
            -- this replaces neodev
            library = {
              '${3rd}/luv/library',
              unpack(vim.api.nvim_get_runtime_file('', true)),
            },
          },
        },
      },
    }
  end,
  -- 'ocamllsp', -- OCaml
  phpantom_lsp = {
    cmd = { vim.fn.expand('~/.cargo/bin/phpantom_lsp') }, -- use global installation over mason
    root_markers = { '.jj' },
  },
  pyright = {
    settings = {
      python = {
        checkOnType = false,
        diagnostics = true,
        inlayHints = true,
        smartCompletion = true,
      },
    },
  },
  -- 'remark_ls', -- Markdown
  rust_analyzer = {},
  sqlls = {},
  tailwindcss = {
    filetypes = {
      'antlers.html',
      'antlers',
      'blade.html.php',
      'blade',
      'html',
      'css',
      'sass',
      'scss',
      'vue',
    },
    settings = {
      tailwindCSS = {
        emmetCompletions = true,
        experimental = {
          classRegex = false,
        },
        classAttributes = {
          'class',
          '@class',
          'className',
          'classList',
          'divClass',
          'imageClass',
          'ngClass',
        },
      },
    },
  },
  taplo = {}, -- toml
  -- ts_ls = {},
  ts_query_ls = {
    settings = {
      parser_install_directories = {
        vim.fs.joinpath(vim.fn.stdpath('data'), '/site/parser/'),
      },
    },
  },
  vtsls = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = '@vue/typescript-plugin',
              location = vim.fn.stdpath('data')
                .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
              languages = { 'vue' },
              configNamespace = 'typescript',
            },
          },
        },
      },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
  vue_ls = {},
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = true,
        },
        format = {
          enable = true,
          singleQuote = true,
        },
        validate = true,
        hover = true,
        completion = true,
      },
    },
  },
}

---@type LazySpec
return {
  {
    'sourcegraph/sg.nvim',
    enabled = false,
    opts = {
      enable_cody = true,
      accept_tos = true,
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'williamboman/mason.nvim',
    ---@type MasonSettings
    opts = {
      -- log_level = vim.log.levels.DEBUG,
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  { -- bridge between mason and lspconfig
    'williamboman/mason-lspconfig',
    ---@type MasonLspconfigSettings
    opts = {
      automatic_enable = false,
      ensure_installed = vim.tbl_keys(servers),
    },
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- enabled = false,
    opts = {
      auto_update = true,
      start_delay = 500,
      ensure_installed = {
        -- LSP Servers --
        'tailwindcss-language-server',

        -- DAP Servers --
        { 'js-debug-adapter', version = 'v1.97.1' },
        'php-debug-adapter',
        'codelldb',

        -- Linters --
        'codespell',
        'curlylint',
        'gitlint',
        'hadolint',
        'markdownlint',
        'proselint',
        'shellcheck',
        'shellharden',
        'sqlfluff',
        'vale',
        'write-good',
        'yamllint',

        -- Formatters --
        'fixjson',
        'luaformatter',
        'prettierd',
        'pgformatter',
        'sql-formatter',
        'yamlfmt',
      },
    },
    dependencies = { 'williamboman/mason.nvim' },
  },
  { -- common configs for built-in LSP client
    'neovim/nvim-lspconfig',
    config = function()
      for name, config in pairs(servers) do
        if type(config) == 'function' then config = config() end

        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end
    end,
    dependencies = {
      'b0o/schemastore.nvim', -- json schemas
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig',
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    enabled = false, -- TODO configure
  },
  'glepnir/lspsaga.nvim', -- UI for LSP client
  { -- ui for lsp progress
    'j-hui/fidget.nvim',
    tag = 'legacy',
  },
}
