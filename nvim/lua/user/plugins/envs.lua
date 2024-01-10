return {
  {
    'ellisonleao/dotenv.nvim',
    opts = {
      enable_on_load = true,
    },
    config = function(_, opts)
      require('dotenv').setup(opts)

      require('dotenv').command({fargs = {
        vim.fs.dirname(vim.uv.fs_realpath(vim.fn.expand('~/.config/nvim/init.lua'))) .. '/../.env',
      }})
    end,
  },
}
