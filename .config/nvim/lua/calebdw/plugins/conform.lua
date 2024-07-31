local slow_format_filetypes = {
  injected = true,
}

return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format({ async = true, lsp_fallback = true, timeout_ms = 5000 }) end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      log_level = vim.log.levels.WARN,
      formatters = {
        prettier = {
          prepend_args = { '--ignore-unknown' },
        },
      },
      formatters_by_ft = {
        blade = { 'prettier', 'blade-formatter', stop_after_first = true },
        json = { 'prettier', 'jq', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        lua = { 'stylua' },
        markdown = { 'prettier', 'markdownlint', stop_after_first = true },
        php = { 'pint', 'phpcbf', 'php_cs_fixer', stop_after_first = true },
        rust = { 'rustfmt', stop_after_first = true },
        sql = { 'pg_format', 'sqlfmt', stop_after_first = true },
        yaml = { 'yamlfmt' },
        ['*'] = { 'injected' },
      },
      format_on_save = function(bufnr)
        if slow_format_filetypes[vim.bo[bufnr].filetype] then return end
        local function on_format(err)
          if err and err:match('timeout$') then slow_format_filetypes[vim.bo[bufnr].filetype] = true end
        end

        return { timeout_ms = 500, lsp_fallback = true }, on_format
      end,
      format_after_save = function(bufnr)
        if slow_format_filetypes[vim.bo[bufnr].filetype] then return end
        return { timeout_ms = 5000, lsp_fallback = true }
      end,
    },
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
  },
}
