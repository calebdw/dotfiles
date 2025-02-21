local map = require('calebdw.util').map

-- Default servers to install
local servers = {
  'ansiblels', -- Ansible
  'antlersls', -- Statamic/Antlers
  -- 'bashls', -- Bash
  'cmake', -- CMake
  'clangd', -- C++
  'cssls', -- CSS
  'cssmodules_ls', -- CSS
  'dockerls', -- Docker
  'emmet_ls', -- Emmet support
  'html', -- HTML
  'jsonls', -- JSON
  -- 'latex', -- LaTeX
  'lemminx', -- XM
  'lua_ls', -- Lua
  -- 'intelephense', -- PHP
  -- 'ocamllsp', -- OCaml
  'phpactor', -- PHP
  -- 'psalm', -- PHP
  -- 'jedi_language_server', -- Python
  'pyright', -- Python
  -- 'pylyzer', -- Python (Rust)
  -- 'pylsp', -- Python
  -- 'quick_lint_js', -- Javascript
  -- 'remark_ls', -- Markdown
  -- 'sqls', -- SQL
  'rust_analyzer', -- Rust
  'sqlls', -- SQL
  'tailwindcss', -- Tailwind CSS
  -- 'tsserver', -- Javascript / TypeScript
  'ts_ls', -- TypeScript
  'volar', -- Vue
  -- 'vuels', -- Vue
  -- 'zeta_note', -- Markdown
  -- 'zk', -- Markdown
  'yamlls', -- YAML
}

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
    opts = {
      automatic_installation = true,
      ensure_installed = servers,
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
        'phpactor',
        'tailwindcss-language-server',

        -- DAP Servers --
        { 'js-debug-adapter', version = 'v1.76.1' },
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
        'sql-formatter',
        'yamlfmt',
      },
    },
    dependencies = { 'williamboman/mason.nvim' },
  },
  { -- common configs for built-in LSP client
    'neovim/nvim-lspconfig',
    config = function()
      local lsp = require('lspconfig')
      local configs = require('lspconfig.configs')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, 'lua/?.lua')
      table.insert(runtime_path, 'lua/?/init.lua')

      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o> DO NOT USE with nvim-cmp
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local opts = {
          buffer = bufnr,
        }

        map('n', '<leader>gD', vim.lsp.buf.declaration, opts)
        map('n', '<leader>gd', vim.lsp.buf.definition, opts)
        map('n', '<leader>k', vim.lsp.buf.signature_help, opts)
        map('n', '<leader>K', vim.lsp.buf.hover, opts)
        map('n', '<leader>gi', vim.lsp.buf.implementation, opts)
        map('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
        map('n', '<leader>gr', vim.lsp.buf.references, opts)
        map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        -- map('n', '<leader>rn', vim.lsp.buf.rename, opts)
        map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        map('n', '<leader>wl', function() vim.print(vim.lsp.buf.list_workspace_folders()) end, opts)
      end

      local handlers = {
        -- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips#use-nvim-notify-to-display-lsp-messages
        ['window/showMessage'] = function(_, result, ctx)
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          if client == nil then return end
          local lvl = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]
          vim.notify(result.message, lvl, {
            title = 'LSP | ' .. client.name,
            timeout = 10000,
            keep = function() return lvl == 'ERROR' or lvl == 'WARN' end,
          })
        end,
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = 'rounded',
        }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = 'rounded',
        }),
      }

      -- local lsp_servers = vim.tbl_values(servers)
      -- table.insert(lsp_servers, 'blade')

      for _, name in pairs(servers) do
        -- apparently this has to be in the loop
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
          handlers = handlers,
        }
        if name == 'antlersls' then
          opts.filetypes = {
            'antlers.html',
            'antlers',
            'html',
          }
        end

        -- if name == 'blade' then
        --   configs.blade = {
        --     default_config = {
        --       cmd = { "laravel-dev-tools", "lsp" },
        --       filetypes = { 'blade' },
        --       root_dir = function(fname)
        --         return lsp.util.find_git_ancestor(fname)
        --       end,
        --       settings = {},
        --     }
        --   }
        -- end

        if name == 'emmet_ls' then
          opts.filetypes = {
            'antlers.html',
            'antlers',
            'blade.html.php',
            'blade',
            'html',
            'css',
            'sass',
            'scss',
          }
        end

        if name == 'html' then
          opts.filetypes = {
            'antlers.html',
            'antlers',
            'blade.html.php',
            'blade',
            'html',
          }
        end

        if name == 'jsonls' then
          opts.settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = {
                enable = true,
              },
            },
          }
        end

        if name == 'phpactor' then
          opts.init_options = {
            ['language_server_phpstan.enabled'] = true,
            ['phpunit.enabled'] = true,
            ['language_server_reference_reference_finder.reference_timeout'] = 600,
            -- ['worse_reflection.stub_dir'] = '%project_root%/_ide_helper',
            -- ['composer.autoloader_path'] = '%project_root%/.autoload.php',
            -- ['indexer.exclude_patterns'] = {'/**/_ide_helper*.php'},
          }
        end

        if name == 'pylyzer' then
          opts.settings = {
            python = {
              checkOnType = false,
              diagnostics = true,
              inlayHints = true,
              smartCompletion = true,
            },
          }
        end

        if name == 'lua_ls' then
          opts.settings = {
            Lua = {
              diagnostics = {
                globals = {
                  -- luasnip globals
                  'ls',
                  's',
                  'sn',
                  'isn',
                  'c',
                  'i',
                  'd',
                  't',
                  'f',
                  'r',
                  'fmt',
                  'fmta',
                },
              },
              runtime = { version = 'LuaJIT', path = runtime_path },
              workspace = {
                -- this replaces neodev
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                checkThirdParty = false,
              },
            },
          }
        end

        if name == 'tailwindcss' then
          opts.filetypes = {
            'antlers.html',
            'antlers',
            'blade.html.php',
            'blade',
            'html',
            'css',
            'sass',
            'scss',
            'vue',
          }
          opts.settings = {
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
          }
        end

        if name == 'ts_ls' then
          opts.filetypes = {
            'typescript',
            'javascript',
            'vue',
            'json',
          }
        end

        if name == 'volar' then
          opts.init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = {"javascript", "typescript", "vue"},
              },
            },
          }
          opts.filetypes = {
            'typescript',
            'javascript',
            'vue',
          }
        end

        if name == 'yamlls' then
          opts.settings = {
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
          }
        end

        -- vim.lsp.set_log_level('debug')
        lsp[name].setup(opts)
      end
    end,
    dependencies = {
      'b0o/schemastore.nvim', -- json schemas
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
    },
  },
  {
    'gbprod/phpactor.nvim',
    -- build = function() require('phpactor.handler.update') end, -- To install/update phpactor when installing this plugin
    opts = {
      install = {
        bin = vim.fn.stdpath('data') .. '/mason/bin/phpactor',
      },
      lspconfig = {
        enabled = false,
      },
    },
    config = function(_, opts)
      local phpactor = require('phpactor')
      phpactor.setup(opts)

      map('n', '<leader>pa', phpactor.rpc)
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
  },
  'glepnir/lspsaga.nvim', -- UI for LSP client
  { -- ui for lsp progress
    'j-hui/fidget.nvim',
    tag = 'legacy',
  },
  {
    'smjonas/inc-rename.nvim',
    opts = {
      save_in_cmd_history = false,
    },
    keys = {
      {
        '<leader>rn',
        function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
        expr = true,
        desc = 'Incremental Rename',
      },
    },
  },
}
