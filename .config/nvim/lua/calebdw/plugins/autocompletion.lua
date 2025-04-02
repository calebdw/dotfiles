---@type LazySpec
return {
  'saghen/blink.cmp',
  build = 'cargo build --release',
  event = 'InsertEnter',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'normal' },
    completion = { documentation = { auto_show = true } },
    snippets = { preset = 'luasnip' },
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" },
  dependencies = {
    -- 'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip' },
  },
}
-- return {
--   'hrsh7th/nvim-cmp',
--   opts = function()
--     local cmp = require('cmp')
--     local lspkind = require('lspkind')
--     local luasnip = require('luasnip')
--     local tailwindcss = require('cmp-tailwind-colors')
--
--     return {
--       snippet = {
--         expand = function(args) luasnip.lsp_expand(args.body) end,
--       },
--       formatting = {
--         format = lspkind.cmp_format({
--           before = tailwindcss.format,
--         }),
--       },
--       mapping = cmp.mapping.preset.insert({
--         -- maybe use <c-y>?
--         ['<cr>'] = cmp.mapping.confirm({ select = false }),
--         ['<c-b>'] = cmp.mapping.scroll_docs(-4),
--         ['<c-f>'] = cmp.mapping.scroll_docs(4),
--         ['<c-space>'] = cmp.mapping.complete(),
--       }),
--       sources = cmp.config.sources({
--         -- order matters (priority)
--         { name = 'nvim_lsp_signature_help' },
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--         { name = 'nvim_lua' },
--         { name = 'buffer' },
--         { name = 'path' },
--         { name = 'git' },
--         { name = 'npm' },
--         { name = 'emoji' },
--         { name = 'vim-dadbod-completion' },
--         -- {name = 'buffer-lines'},
--         { name = 'nvim_lsp_document_symbol' },
--       }),
--       experimental = {
--         ghost_text = true,
--       },
--     }
--   end,
--   config = function(_, opts)
--     local cmp = require('cmp')
--     local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--
--     cmp.setup(opts)
--
--     cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'daupui_hover' }, {
--       sources = {
--         { name = 'dap' },
--       },
--     })
--
--     cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
--
--     require('cmp_git').setup()
--   end,
--   dependencies = {
--     'L3MON4D3/LuaSnip',
--     'windwp/nvim-autopairs', -- is this needed?
--     'saadparwaiz1/cmp_luasnip',
--     'hrsh7th/cmp-nvim-lsp',
--     'hrsh7th/cmp-nvim-lua',
--     'hrsh7th/cmp-buffer',
--     'amarakon/nvim-cmp-buffer-lines',
--     'hrsh7th/cmp-path',
--     'hrsh7th/cmp-nvim-lsp-signature-help',
--     'hrsh7th/cmp-nvim-lsp-document-symbol',
--     'hrsh7th/cmp-cmdline',
--     'hrsh7th/cmp-emoji',
--     {
--       'onsails/lspkind.nvim',
--       opts = {
--         symbol_map = {
--           Field = '',
--           Variable = '',
--           Reference = '',
--           TypeParameter = '',
--         },
--       },
--       config = function(_, opts) require('lspkind').init(opts) end,
--     },
--     'petertriho/cmp-git',
--     'David-Kunz/cmp-npm',
--     'kristijanhusak/vim-dadbod-completion',
--     'rcarriga/cmp-dap',
--     'js-everts/cmp-tailwind-colors',
--   },
-- }
