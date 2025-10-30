_G.configs = require('settings')
local wezterm = require('wezterm')

local config = wezterm.config_builder()
local colors = require('colors')
local fonts = require('fonts')
local keys = require('keys')
local events = require('events')

-- configs
config.window_decorations = 'RESIZE | INTEGRATED_BUTTONS'
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = 'NeverPrompt'
config.default_prog = _G.configs.shell
config.window_content_alignment = {
    horizontal = 'Center',
    vertical = 'Center',
}
config.window_padding = {
    left = '0.5cell',
    right = '0.5cell',
    top = 0,
    bottom = 0,
}
config.inactive_pane_hsb = {
    saturation = 1,
    brightness = 0.7,
}

colors.setup_colors(config)
fonts.setup_fonts(config)
keys.setup_keys(config)
events.setup_events()

return config
