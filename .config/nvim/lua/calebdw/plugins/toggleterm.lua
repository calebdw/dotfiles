-- numToStr/FTerm.nvim
---@type LazySpec
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
        return math.ceil(vim.api.nvim_get_option_value("columns", { scope = 'global'}) * .8)
      end,
      height = function()
        return math.ceil(vim.api.nvim_get_option_value("lines", { scope = 'global'}) * .8 - 4)
      end
    },
    winbar = {
      enabled = true,
    },
  },
}
