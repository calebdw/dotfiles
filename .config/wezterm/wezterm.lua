local wezterm = require('wezterm');
local config = wezterm.config_builder()

-- Fonts --
config.font = wezterm.font_with_fallback({
  'FiraCode Nerd Font',
  -- 'JetBrainsMono Nerd Font',
  'Nonicons',
})

-- Colors --
config.color_scheme = 'tokyonight_night'

-- Window --
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "NONE"
config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.audible_bell = "Disabled"

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

return config
