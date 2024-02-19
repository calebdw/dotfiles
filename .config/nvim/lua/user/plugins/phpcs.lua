return {
  'praem90/nvim-phpcsf',
  enabled = false,
  config = function()
    vim.g.nvim_phpcs_config_phpcs_path = 'phpcs'
    vim.g.nvim_phpcs_config_phpcbf_path = 'phpcbf'
    vim.g.nvim_phpcs_config_phpcs_standard = 'PSR12' -- or path to your ruleset phpcs.xml

    vim.api.nvim_create_autocmd(
      { 'BufWritePost', 'BufReadPost', 'CursorHold', 'CursorHoldI' },
      {
        group = vim.api.nvim_create_augroup('PHPCS', { clear = true }),
        pattern = '*.php',
        callback = function()
          require('phpcs').cs()
          -- require('phpcs').cbf()
        end,
      }
    )
  end,
}
