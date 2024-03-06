return {
  {
    'ellisonleao/dotenv.nvim',
    opts = { enable_on_load = true },
    config = function(_, opts)
      require('dotenv').setup(opts)

      local dotfiles = vim.uv.fs_realpath(vim.fn.expand('~/.config/nvim/init.lua'))

      assert(dotfiles, 'Could not find dotfiles')

      require('dotenv').command({
        fargs = { vim.fs.dirname(dotfiles) .. '/../.env' }
      })
    end,
  },
}
