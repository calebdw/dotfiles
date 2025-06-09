local wezterm = require('wezterm');
local config = wezterm.config_builder()

config.default_prog = { '/usr/bin/fish', '-l' }

-- Fonts --
config.font = wezterm.font_with_fallback({
  'FiraCode Nerd Font',
  -- 'JetBrainsMono Nerd Font',
  'nonicons',
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

config.quick_select_remove_styling = true
config.quick_select_patterns = {
  '[k-z]{6,40}', -- JJ ChangeID
}

wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

return config
