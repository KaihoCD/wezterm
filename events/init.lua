local wezterm = require("wezterm")
local colors = require("colors")
local act = wezterm.action
local utils = require("events.utils")

local icons = {
	folder_icon = "󰝰 ",
	device_icon = "󰊠 ",
	exec_icons = {
		node = "",
		python = "",
		fzf = "",
		nvim = "",
		vim = "",
		default = "󰨊",
	},
	-- stylua: ignore
	tab_sup_index = { "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹" },
}

-- 缓存主题列表
local schemes = wezterm.get_builtin_color_schemes()

-- 事件名称枚举
local EVENTS = {
	UPDATE_RIGHT_STATUS = "update-right-status",
	FORMAT_TAB_TITLE = "format-tab-title",
	UPDATE_THEME = "update-theme",
	TRIGGER_THEME_PICKER = "trigger-theme-picker",
	CLOSE_CURRENT_PANE = "close-current-pane",
}

local events = {
	[EVENTS.UPDATE_RIGHT_STATUS] = function(window, pane)
		local dir = utils.get_current_working_dir(pane)
		local device = utils.get_device_name(icons)
		local inner_colors = colors.get_colors()

		window:set_right_status(wezterm.format({
			{ Foreground = { Color = inner_colors.fg } },
			{ Background = { Color = inner_colors.dark_bg } },
			{ Text = icons.folder_icon },
			{ Foreground = { Color = inner_colors.light_fg } },
			{ Text = " " .. dir },
			{ Foreground = { Color = inner_colors.fg } },
			{ Text = "   " .. icons.device_icon },
			{ Foreground = { Color = inner_colors.light_fg } },
			{ Text = " " .. device .. "   " },
		}))
	end,
	[EVENTS.FORMAT_TAB_TITLE] = function(tab)
		local process_name = tab.active_pane.foreground_process_name

		local exec_name = utils.basename(process_name)
		if exec_name and exec_name:match("%.%w+$") then
			exec_name = exec_name:match("^(.-)%.%w+$")
		end

		local title_name = exec_name:upper()
		local title_icon = icons.exec_icons[exec_name] or icons.exec_icons.default
		local title_sup_index = icons.tab_sup_index[tab.tab_index + 1]

		return {
			{ Text = " " .. title_icon },
			{ Text = "   " .. title_name },
			{ Text = " " .. title_sup_index },
		}
	end,
	[EVENTS.UPDATE_THEME] = function(window, pane)
		window:set_config_overrides(require("colors").make_color_config(_G.configs.themes))
		wezterm.emit(EVENTS.UPDATE_RIGHT_STATUS, window, pane)
	end,
	[EVENTS.TRIGGER_THEME_PICKER] = function(window, pane)
		local choices = {}

		for key, _ in pairs(schemes) do
			table.insert(choices, { label = tostring(key) })
		end

		window:perform_action(
			act.InputSelector({
				choices = choices,
				fuzzy_description = "🎨 Pick a Theme 🎨 and press `Enter` = accept: ",
				fuzzy = true,
				action = wezterm.action_callback(function(inner_window, _, _, label)
					if label then
						_G.configs.themes = label
						wezterm.emit(EVENTS.UPDATE_THEME, inner_window)
					end
				end),
			}),
			pane
		)
	end,
	[EVENTS.CLOSE_CURRENT_PANE] = function(window, pane)
		local proc = pane:get_foreground_process_name() or ""
		if utils.is_idle_shell(proc) and not utils.is_final_pane(window) then
			return window:perform_action(act.CloseCurrentPane({ confirm = false }), pane)
		else
			return window:perform_action(
				act.InputSelector({
					alphabet = "",
					fuzzy = true,
					choices = {
						{ label = "[✓] Yes, close this tab", id = "true" },
						{ label = "[×] No, keep it open", id = "false" },
					},
					fuzzy_description = "🗂️ Do you really want to close this tab? ",
					action = wezterm.action_callback(function(win, _, id)
						if id == "true" then
							win:perform_action(act.CloseCurrentTab({ confirm = false }), pane)
						end
					end),
				}),
				pane
			)
		end
	end,
}

return {
	event_names = EVENTS,
	setup_events = function()
		for event_name, handler in pairs(events) do
			wezterm.on(event_name, handler)
		end
	end,
}
