local wezterm = require("wezterm")
local utils = require("utils")
local event_names = require("events").event_names
local act = wezterm.action

local function map(key, mods, action)
	return {
		key = key,
		mods = mods,
		action = action,
	}
end

local function get_cwd()
	return utils.get_os_type({
		windows = function()
			return (os.getenv("USERPROFILE") or "") .. "\\.config\\wezterm"
		end,
		default = function()
			return (os.getenv("HOME") or "") .. "/.config/wezterm"
		end,
	})
end

local keys = {
	-- Copy and paste
	utils.get_os_type({
		macos = map("c", "SUPER|SHIFT", act.CopyTo("Clipboard")),
		default = map("c", "CTRL|SHIFT", act.CopyTo("Clipboard")),
	}),
	utils.get_os_type({
		macos = map("v", "SUPER|SHIFT", act.PasteFrom("Clipboard")),
		default = map("v", "CTRL|SHIFT", act.PasteFrom("Clipboard")),
	}),
	-- Modes
	map("y", "LEADER", act.ActivateCopyMode),
	map("p", "LEADER", act.PasteFrom("Clipboard")),
	map("f", "LEADER", act.Search({ CaseSensitiveString = "" })),
	-- Pane and tab
	map("h", "LEADER|CTRL", act.ActivatePaneDirection("Left")),
	map("j", "LEADER|CTRL", act.ActivatePaneDirection("Down")),
	map("k", "LEADER|CTRL", act.ActivatePaneDirection("Up")),
	map("l", "LEADER|CTRL", act.ActivatePaneDirection("Right")),
	map("H", "LEADER|SHIFT", act.ActivateTabRelative(-1)),
	map("L", "LEADER|SHIFT", act.ActivateTabRelative(1)),
	map("w", "LEADER", act.EmitEvent(event_names.CLOSE_CURRENT_PANE)),
	map("t", "LEADER", act.SpawnTab("CurrentPaneDomain")),
	map("LeftArrow", "LEADER", act.MoveTabRelative(-1)),
	map("RightArrow", "LEADER", act.MoveTabRelative(1)),
	map("v", "LEADER", act.SplitPane({ direction = "Right", size = { Percent = 50 } })),
	map("s", "LEADER", act.SplitPane({ direction = "Down", size = { Percent = 50 } })),
	-- Font size
	map("0", "LEADER", act.ResetFontSize),
	map("=", "LEADER", act.IncreaseFontSize),
	map("-", "LEADER", act.DecreaseFontSize),
	-- Trigger theme picker
	map("T", "LEADER", act.EmitEvent(event_names.TRIGGER_THEME_PICKER)),
	-- Goto configs
	map("e", "LEADER", act.SpawnCommandInNewTab({ cwd = get_cwd() })),
}

for i = 1, 9 do
	table.insert(keys, map(tostring(i), "LEADER", act.ActivateTab(i - 1)))
end

return {
	setup_keys = function(wezterm_config)
		wezterm_config.leader = {
			key = " ",
			mods = "SHIFT",
			timeout_milliseconds = 1500,
		}
		wezterm_config.disable_default_key_bindings = true
		wezterm_config.keys = keys
	end,
}
