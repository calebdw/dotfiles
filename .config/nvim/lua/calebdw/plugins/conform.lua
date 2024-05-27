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
        function()
          require('conform').format({ async = true, lsp_fallback = true, timeout_ms = 5000 })
        end,
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
        blade = { { 'prettier', 'blade-formatter' } },
        json = { { 'prettier', 'jq' } },
        javascript = { { 'prettierd', 'prettier' } },
        lua = { 'stylua' },
        php = { { 'pint', 'phpcbf', 'php_cs_fixer' } },
        sql = { { 'pg_format', 'sqlfmt' } },
        ['*'] = { 'injected' },
      },
      format_on_save = function(bufnr)
        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        local function on_format(err)
          if err and err:match('timeout$') then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end

        return { timeout_ms = 500, lsp_fallback = true }, on_format
      end,
      format_after_save = function(bufnr)
        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { timeout_ms = 5000, lsp_fallback = true }
      end,
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
