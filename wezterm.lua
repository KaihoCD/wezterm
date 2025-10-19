local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "Tokyo Night"
config.font_size = 14
config.window_decorations = "RESIZE | INTEGRATED_BUTTONS"
config.status_update_interval = 5000
-- config.disable_default_key_bindings = true
config.leader = {
	key = " ",
	mods = "SHIFT",
	timeout_milliseconds = 1500,
}
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "Medium",
		style = "Normal",
	},
	{
		family = "Symbols Nerd Font",
		weight = "Medium",
		style = "Normal",
	},
})
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

local function map(key, mods, action)
	return {
		key = key,
		mods = mods,
		action = action,
	}
end

local function create_key_binding(key, mods, action)
  return {
    key = key,
    mods = mods,
    action = action,
  }
end

config.keys = {
	map("y", "LEADER", act.ActivateCopyMode),
	map("p", "LEADER", act.PasteFrom("Clipboard")),
	map("f", "LEADER", act.Search({ CaseSensitiveString = "" })),
	map("h", "LEADER|CTRL", act.ActivatePaneDirection("Left")),
	map("j", "LEADER|CTRL", act.ActivatePaneDirection("Down")),
	map("k", "LEADER|CTRL", act.ActivatePaneDirection("Up")),
	map("l", "LEADER|CTRL", act.ActivatePaneDirection("Right")),
	map("H", "LEADER|SHIFT", act.ActivateTabRelative(-1)),
	map("L", "LEADER|SHIFT", act.ActivateTabRelative(1)),
	map("w", "LEADER", act.CloseCurrentPane({ confirm = true })),
	map("t", "LEADER", act.SpawnTab("CurrentPaneDomain")),
	map("LeftArrow", "LEADER", act.MoveTabRelative(-1)),
	map("RightArrow", "LEADER", act.MoveTabRelative(1)),
	map("v", "LEADER", act.SplitPane({ direction = "Right", size = { Percent = 50 } })),
	map("s", "LEADER", act.SplitPane({ direction = "Down", size = { Percent = 50 } })),
}

-- Ensure the function is defined before adding key bindings
for i = 1, 9 do
  table.insert(config.keys, create_key_binding(tostring(i), "LEADER", act.ActivateTab(i - 1)))
end

return config
