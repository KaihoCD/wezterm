local wezterm = require('wezterm')

local M = {}

-- 获取文件名
function M.basename(s)
    if not s or type(s) ~= 'string' then
        return
    end
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

-- 判断是否为闲置的 shell 进程
function M.is_idle_shell(process_name)
    local shells = { 'bash', 'zsh', 'pwsh', 'powershell', 'cmd.exe', 'sh' }
    for _, shell in ipairs(shells) do
        if process_name:find(shell) then
            return true
        end
    end
    return false
end

-- 获取当前用户
function M.get_current_user()
    local user = os.getenv('USER') -- macOS / Linux
        or os.getenv('LOGNAME')
        or os.getenv('USERNAME') -- Windows
    return user or nil
end

-- 将UTI处理为普通路径
function M.uri_to_path(uri)
    if not uri then
        return nil
    end
    if type(uri) ~= 'string' then
        uri = tostring(uri or '')
    end
    local path = uri:gsub('^file://', '')
    if wezterm.target_triple:find('windows') then
        path = path:gsub('^/([A-Za-z]:)', '%1') -- /C:/ → C:\
    end
    return path
end

-- 从 file:// URI 提取最后一级目录名（PaneInformation）
function M.extract_dir_from_uri(cwd_uri)
    local path = M.uri_to_path(cwd_uri)
    if not path then
        return ''
    end

    -- 提取最后一级目录
    local dir = path:match('([^/\\]+)[/\\]?$') or path

    -- 替换 HOME 为 ~
    local home = os.getenv('HOME') or os.getenv('USERPROFILE')
    if home and dir:sub(1, #home) == home then
        dir = '~' .. dir:sub(#home + 1)
    end

    return dir
end

-- 判断是否是最后一个tab的最后一个pane
function M.is_final_pane(window)
    local tabs = window:mux_window():tabs_with_info()
    local current_tab = window:active_tab()
    local panes = current_tab:panes()
    return (#tabs == 1) and (#panes == 1)
end

return M
