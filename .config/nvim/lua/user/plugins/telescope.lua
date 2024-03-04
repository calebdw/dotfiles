return {
  'nvim-telescope/telescope.nvim',
  opts = function()
    local actions = require('telescope.actions')
    local lga_actions = require('telescope-live-grep-args.actions')

    return {
      defaults   = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<c-b>'] = actions.results_scrolling_up,
            ['<c-f>'] = actions.results_scrolling_down,
          },
          n = {
            ['<c-b>'] = actions.results_scrolling_up,
            ['<c-f>'] = actions.results_scrolling_down,
          },
        },
        file_ignore_patterns = {
          '.git/',
          'public/vendor',
        },
        -- let telescope search in hidden files
        vimgrep_arguments = {
          'rg',
          '--hidden',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          "--smart-case"
        },
      },
      pickers    = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<c-k>'] = lga_actions.quote_prompt(),
              ['<c-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
              ['<c-u>'] = lga_actions.quote_prompt({ postfix = ' -uu ' }),
            },
          },
        },
        undo = {
          side_by_side = true,
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local extensions = telescope.extensions
    local map = require('user.util').map

    telescope.setup(opts)

    telescope.load_extension('dap')
    telescope.load_extension('env')
    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')
    telescope.load_extension('notify')
    telescope.load_extension('persisted')
    telescope.load_extension('projects')
    telescope.load_extension('ui-select')
    telescope.load_extension('undo')

    -- Keymaps
    map({ 'n', 'v' }, '<leader>ff', builtin.find_files)
    map({ 'n', 'v' }, '<leader>fa', function()
      builtin.find_files({
        no_ignore = true,
        prompt_title = 'All Files',
      })
    end)
    map({ 'n', 'v' }, '<leader>fl', extensions.live_grep_args.live_grep_args)
    map({ 'n', 'v' }, '<leader>fb', builtin.buffers)
    map({ 'n', 'v' }, '<leader>fh', builtin.help_tags)
    map({ 'n', 'v' }, '<leader>ft', builtin.tags)
    map({ 'n', 'v' }, '<leader>fq', builtin.quickfix)
    map({ 'n', 'v' }, '<leader>fg', builtin.grep_string)

    map({ 'n', 'v' }, '<leader>tc', builtin.git_commits)
    map({ 'n', 'v' }, '<leader>Tb', builtin.git_branches)
    map({ 'n', 'v' }, '<leader>ts', builtin.git_status)
    map({ 'n', 'v' }, '<leader>tS', builtin.git_stash)

    map({ 'n', 'v' }, '<leader>tt', builtin.treesitter)
    map({ 'n', 'v' }, '<leader>tR', builtin.reloader)
    map({ 'n', 'v' }, '<leader>tr', builtin.resume)
    map({ 'n', 'v' }, '<leader>tp', extensions.projects.projects)
    map({ 'n', 'v' }, '<leader>tP', extensions.persisted.persisted)
    map({ 'n', 'v' }, '<leader>tu', extensions.undo.undo)

    map({ 'n', 'v' }, '<leader>Td', builtin.lsp_definitions)
    map({ 'n', 'v' }, '<leader>Ti', builtin.lsp_implementations)
    map({ 'n', 'v' }, '<leader>Tt', builtin.lsp_type_definitions)
    map({ 'n', 'v' }, '<leader>TD', builtin.diagnostics)
    map({ 'n', 'v' }, '<leader>Tr', builtin.lsp_references)
    map({ 'n', 'v' }, '<leader>Ts', builtin.lsp_document_symbols)
    map({ 'n', 'v' }, '<leader>Tw', builtin.lsp_workspace_symbols)
    map({ 'n', 'v' }, '<leader>TW', builtin.lsp_dynamic_workspace_symbols)

    map({ 'n', 'v' }, '<leader>dc', extensions.dap.commands)
    map({ 'n', 'v' }, '<leader>dC', extensions.dap.configurations)
    map({ 'n', 'v' }, '<leader>db', extensions.dap.list_breakpoints)
    map({ 'n', 'v' }, '<leader>dv', extensions.dap.variables)
    map({ 'n', 'v' }, '<leader>df', extensions.dap.frames)
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
    'LinArcX/telescope-env.nvim',
    'nvim-telescope/telescope-dap.nvim',
    'debugloop/telescope-undo.nvim',
  },
}
