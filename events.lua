local wezterm = require("wezterm")
local colors = require("colors").colors

local icons = {
	folder_icon = " ",
	device_icon = " ",
	exec_icons = {
		default = "󰨊",
		python = "",
		nvim = "",
		node = "",
		fzf = "",
	},
	tab_sup_index = {
		"¹",
		"²",
		"³",
		"⁴",
		"⁵",
		"⁶",
		"⁷",
		"⁸",
		"⁹",
	},
}

-- 获取文件名
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- 获取当前设备名称
local function get_device_name()
	local hostname = wezterm.hostname()
	-- 移除 .local 后缀（如果存在）
	hostname = hostname:gsub("%.local$", "")
	return icons.device_icon .. " " .. hostname
end

-- 获取当前工作目录名称
local function get_current_working_dir(pane)
	return icons.folder_icon .. "  " .. (pane:get_current_working_dir().path:match("([^/]+)$") or "")
end

local events = {
	["update-right-status"] = function(window, pane)
		local dir = get_current_working_dir(pane)
		local device = get_device_name()

		window:set_right_status(wezterm.format({
			{ Foreground = { Color = colors.fg } },
			{ Background = { Color = colors.dark_bg } },
			{ Text = dir .. "    " .. device .. "    " },
		}))
	end,
	["format-tab-title"] = function(tab)
		local process_name = tab.active_pane.foreground_process_name

		local exec_name = basename(process_name)
		if exec_name:match("%.%w+$") then
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
}

return {
    setup_events = function()
        for event_name, handler in pairs(events) do
            wezterm.on(event_name, handler)
        end
    end
}
