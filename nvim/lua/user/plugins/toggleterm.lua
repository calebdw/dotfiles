-- numToStr/FTerm.nvim
return {
  'akinsho/toggleterm.nvim',
  opts = {
    open_mapping = '<f2>',
    direction = 'float',
    highlights = {
      NormalFloat = {
        link = 'NormalFloat',
      },
      FloatBorder = {
        link = 'FloatBorder',
      },
    },
    float_opts = {
      border = 'rounded',
      width = function()
        return math.ceil(vim.api.nvim_get_option("columns") * .8)
      end,
      height = function()
        return math.ceil(vim.api.nvim_get_option("lines") * .8 - 4)
      end
    },
    winbar = {
      enabled = true,
    },
  },
}
