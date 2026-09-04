---@type LazySpec
return {
  {
    'ellisonleao/dotenv.nvim',
    opts = {
      enable_on_load = true,
      file_name = '~/.config/nvim/.env',
    },
  },
}
