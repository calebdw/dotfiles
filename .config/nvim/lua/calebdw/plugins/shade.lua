---@type LazySpec
return {
  'sunjon/shade.nvim',
  -- Conflicts with vim-maximizer and many other plugins
  enabled = false,
  opts = {
    overlay_opacity = 50,
    opacity_step = 1,
    keys = {
      brightness_up    = '<c-up>',
      brightness_down  = '<c-down>',
      toggle           = '<leader>s',
    }
  },
}
