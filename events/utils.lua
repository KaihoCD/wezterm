local wezterm = require("wezterm")
local utils = require("utils")

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

-- 获取当前用户
function M.get_current_user()
	local user = os.getenv("USER") -- macOS / Linux
		or os.getenv("LOGNAME")
		or os.getenv("USERNAME") -- Windows
	return user or nil
end

-- 从 file:// URI 提取最后一级目录名（PaneInformation）
function M.extract_dir_from_uri(cwd_uri)
	if not cwd_uri then
		return ""
	end

	if type(cwd_uri) ~= "string" then
		cwd_uri = tostring(cwd_uri or "")
	end

	local path = cwd_uri:match("file://[^/]+(/.+)")
	if path then
		local home = os.getenv("HOME")
		if home and path:sub(1, #home) == home then
			path = "~" .. path:sub(#home + 1)
		end
		return path:match("([^/]+)$") or path
	end
	return ""
end

-- 判断是否是最后一个tab的最后一个pane
function M.is_final_pane(window)
	local tabs = window:mux_window():tabs_with_info()
	local current_tab = window:active_tab()
	local panes = current_tab:panes()
	return (#tabs == 1) and (#panes == 1)
end

-- 获取 node 版本
function M.get_node_version()
	local cmds = utils.get_os_type({
		macos = { "/bin/zsh", "-ic", "node -v" },
		linux = { "/bin/bash", "-ic", "node -v" },
		windows = { "pwsh", "-Command", "node -v" },
		default = { "node", "-v" },
	})

	local ok, out = wezterm.run_child_process(cmds)
	if ok and out then
		return out:gsub("[\r\n]+", "")
	end

	return nil
end

-- 获取当前项目所使用的包管理器
function M.get_project_package_manager(pane)
	if not pane then
		return nil
	end
	local cwd_uri = pane:get_current_working_dir()
	local cwd = cwd_uri and cwd_uri.file_path
	if not cwd then
		return nil
	end

	local lock_files = {
		{ "package-lock.json", "npm" },
		{ "yarn.lock", "yarn" },
		{ "pnpm-lock.yaml", "pnpm" },
		{ "bun.lockb", "bun" },
	}

	for _, lock in ipairs(lock_files) do
		local ok = wezterm.run_child_process({ "test", "-e", cwd .. "/" .. lock[1] })
		if ok then
			return lock[2]
		end
	end
	return nil
end

return M
