local wezterm = require("wezterm")

local M = {}

-- 获取文件名
function M.basename(s)
	if not s or type(s) ~= "string" then
		return
	end
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- 判断是否为闲置的 shell 进程
function M.is_idle_shell(process_name)
	local shells = { "bash", "zsh", "pwsh", "cmd.exe", "sh" }
	for _, shell in ipairs(shells) do
		if process_name:find(shell) then
			return true
		end
	end
	return false
end

-- 获取当前设备名称
function M.get_device_name(icons)
	local hostname = wezterm.hostname()
	if not hostname or type(hostname) ~= "string" then
		return icons.device_icon .. " Mysterious Guest"
	end
	hostname = hostname:gsub("%.local$", "")
	return hostname
end

-- 获取当前工作目录名称
function M.get_current_working_dir(pane)
	if not pane then
		return ""
	end

	local ok, res = pcall(function()
		return pane:get_current_working_dir()
	end)

	if not ok or not res or not res.path then
		return ""
	end

	local cwd = res.path or ""
	cwd = cwd:gsub("/$", "")
	local home = os.getenv("HOME")
	if home and cwd == home then
		return "~"
	end
	if home and cwd:sub(1, #home + 1) == home .. "/" then
		cwd = "~" .. cwd:sub(#home + 1)
	end
	return cwd:match("([^/]+)$") or cwd
end

-- 判断是否是最后一个tab的最后一个pane
function M.is_final_pane(window)
	local tabs = window:mux_window():tabs_with_info()
	local current_tab = window:active_tab()
	local panes = current_tab:panes()
	return (#tabs == 1) and (#panes == 1)
end

return M
