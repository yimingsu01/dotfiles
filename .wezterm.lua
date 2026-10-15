-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 40

-- or, changing the font size and color scheme.
config.font_size = 13

config.font = wezterm.font_with_fallback({
  { family = 'IoskeleyMonoNL Nerd Font Mono', weight = 'Medium' },
  'Symbols Nerd Font Mono',
})

function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return '3024 (base16)'
  else
    return "Catppuccin Latte"
  end
end

-- config.color_scheme = '3024 (base16)'
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.window_padding = {
  left = 1,
  right = 1,
  top = 0,
  bottom = 0,
}

config.keys = config.keys or {}
table.insert(config.keys, {
  key = 'P', mods = 'ALT|SHIFT',
  action = wezterm.action.SendString('\x1b[112;4u'),
})
table.insert(config.keys, {
  key = 'N', mods = 'ALT|SHIFT',
  action = wezterm.action.SendString('\x1b[110;4u'),
})


return config
