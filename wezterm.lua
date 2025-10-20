local wezterm = require("wezterm")
local utils = require("utils")

local config = wezterm.config_builder()
local act = wezterm.action

-------------------------
-- template -------------
-------------------------

config.font_size = 14
config.window_decorations = "RESIZE | INTEGRATED_BUTTONS"
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-------------------------
-- font -----------------
-------------------------

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

-------------------------
-- 颜色 -----------------
-------------------------

local CUR_THEME = "Tokyo Night"

local gen_theme_palette = function(theme_name)
	-- 获取内置主题颜色
	local colors = wezterm.get_builtin_color_schemes()[theme_name]
	-- 基本色
	local r = {
		bg = colors.background,
		fg = colors.foreground,
	}
	-- 动态计算衍生颜色
	local meta = utils.detect_theme_type(r.bg, r.fg)
	if meta.is_dark then
		r.dark_bg = utils.blend(r.bg, 0.85, r.fg)
		r.light_fg = utils.blend(r.fg, 0.65, r.bg)
	else
		r.dark_bg = utils.blend(r.bg, 0.85, r.fg)
		r.light_fg = utils.blend(r.fg, 0.85, r.bg)
	end
	return r
end

local colors = gen_theme_palette(CUR_THEME)

config.color_scheme = CUR_THEME

config.window_frame = {
	inactive_titlebar_bg = colors.dark_bg,
	active_titlebar_bg = colors.dark_bg,
}

local function gen_config(bg, fg)
	return { bg_color = bg, fg_color = fg, intensity = "Bold" }
end

config.colors = {
	tab_bar = {
		active_tab = gen_config(colors.bg, colors.fg),
		inactive_tab = gen_config(utils.blend(colors.dark_bg, 0.5, colors.bg), colors.light_fg),
		inactive_tab_edge = colors.light_fg,
		inactive_tab_hover = gen_config(colors.bg, colors.light_fg),
		new_tab = gen_config(colors.dark_bg, colors.light_fg),
		new_tab_hover = gen_config(colors.dark_bg, colors.fg),
	},
}

------------------------
-- tab title -----------
------------------------

local exec_icons = {
	default = "󰨊",
	python = "",
	nvim = "",
	node = "",
	fzf = "",
}

local tab_sup_index = {
	"¹",
	"²",
	"³",
	"⁴",
	"⁵",
	"⁶",
	"⁷",
	"⁸",
	"⁹",
}

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- 获取当前程序的图标
local function cur_exec_icon(exec_name)
	for key, icon in pairs(exec_icons) do
		if key ~= "_default" and string.find(exec_name:lower(), key:lower()) then
			return icon
		end
	end
	return exec_icons.default
end

-- 获取当前tab的上标
local function cur_tab_sup_index(index)
	return tab_sup_index[index]
end

wezterm.on("format-tab-title", function(tab)
	local process_name = tab.active_pane.foreground_process_name

	local exec_name = basename(process_name)
	if exec_name:match("%.%w+$") then
		exec_name = exec_name:match("^(.-)%.%w+$")
	end

	local title_name = exec_name:upper()
	local title_icon = cur_exec_icon(exec_name)
	local title_sup_index = cur_tab_sup_index(tab.tab_index + 1)

	return {
		{ Text = " " .. title_icon },
		{ Text = "   " .. title_name },
		{ Text = " " .. title_sup_index },
	}
end)

-------------------------
-- right status ---------
-------------------------

local folder_icon = " "
local device_icon = " "

-- 获取当前设备名称
local function get_device_name()
	local hostname = wezterm.hostname()
	print(hostname)
	-- 移除 .local 后缀（如果存在）
	hostname = hostname:gsub("%.local$", "")
	return device_icon .. " " .. hostname
end

-- 获取当前工作目录名称
local function get_current_working_dir(pane)
	return folder_icon .. "  " .. (pane:get_current_working_dir().path:match("([^/]+)$") or '')
end

wezterm.on("update-right-status", function(window, pane)
	local dir = get_current_working_dir(pane)
	local device = get_device_name()

	window:set_right_status(wezterm.format({
		{ Foreground = { Color = colors.fg } },
		{ Background = { Color = colors.dark_bg } },
		{ Text = dir .. "    " .. device .. "    " },
	}))
end)

-------------------------
-- launch menu ----------
-------------------------

config.launch_menu = {
	{
		label = "SSH - Production Server",
		args = { "ssh", "user@production.example.com" },
	},
	{
		label = "SSH - Development Server",
		args = { "ssh", "user@dev.example.com" },
	},
	{
		label = "SSH - Local VM",
		args = { "ssh", "user@192.168.1.100" },
	},
	{
		label = "SSH - GitHub",
		args = { "ssh", "git@github.com" },
	},
	{
		label = "Local Bash",
		args = { "bash", "-l" },
	},
	{
		label = "Local Zsh",
		args = { "zsh", "-l" },
	},
}

-------------------------
-- key map --------------
-------------------------

-- config.disable_default_key_bindings = true
config.leader = {
	key = " ",
	mods = "SHIFT",
	timeout_milliseconds = 1500,
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
	-- 打开启动菜单（只显示自定义选项）
	map("m", "LEADER", act.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS" })),
}

-- Ensure the function is defined before adding key bindings
for i = 1, 9 do
	table.insert(config.keys, create_key_binding(tostring(i), "LEADER", act.ActivateTab(i - 1)))
end

return config
