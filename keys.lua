local wezterm = require("wezterm")
local utils = require("utils")
local act = wezterm.action

local function map(key, mods, action)
	return {
		key = key,
		mods = mods,
		action = action,
	}
end

-- 判断可执行文件是否存在
local function exists(cmd)
    local check = "which " .. cmd .. " >/dev/null 2>&1"
    if wezterm.target_triple:find("windows") then
        check = "where " .. cmd .. " >nul 2>nul"
    end
    local ok = os.execute(check)
    return ok == 0 or ok == true
end

local function get_editor()
    if exists("nvim") then
        return { "nvim", "." }
    elseif exists("vim") then
        return { "vim", "." }
    elseif exists("code") then
        return { "code", "." }
    else
        return utils.get_os_type({
            macos = { "open", "." },
            windows = { "explorer", "." },
            linux = { "xdg-open", "." },
            default = { "echo", "No suitable editor found." }
        })
    end
end

local keys = {
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
	map("0", "LEADER", act.ResetFontSize),
	map("=", "LEADER", act.IncreaseFontSize),
	map("-", "LEADER", act.DecreaseFontSize),
	-- 快速编辑配置
	map(
		"e",
		"LEADER",
		act.SpawnCommandInNewTab({
			cwd = os.getenv("HOME") .. "/.config/wezterm",
			args = get_editor(),
		})
	),
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
