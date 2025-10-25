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
	-- 优先用 LuaFileSystem 检查 PATH
	local ok, lfs = pcall(require, "lfs")
	if ok and lfs and type(lfs.attributes) == "function" then
		local path_sep = package.config:sub(1, 1)
		local path_env = os.getenv("PATH") or ""
		for dir in string.gmatch(path_env, "([^" .. (path_sep == "\\" and ";" or ":") .. "]+)") do
			local full = dir .. path_sep .. cmd .. (wezterm.target_triple:find("windows") and ".exe" or "")
			if lfs.attributes(full, "mode") then
				return true
			end
		end
		return false
	end
	-- fallback: 直接返回 true，避免 GUI 闪烁
	return true
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
			default = { "echo", "No suitable editor found." },
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
			cwd = get_cwd(),
			args = get_editor(),
		})
	),
}

print({
	cwd = get_cwd(),
	args = get_editor(),
})

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
