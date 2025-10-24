_G.configs = require("settings")
local wezterm = require("wezterm")

local config = wezterm.config_builder()
local colors = require("colors")
local fonts = require("fonts")
local keys = require("keys")
local events = require("events")

-- configs
config.window_decorations = "RESIZE | INTEGRATED_BUTTONS"
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

colors.setup_colors(config)
fonts.setup_fonts(config)
keys.setup_keys(config)
events.setup_events()

return config
