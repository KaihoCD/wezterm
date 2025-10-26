local M = {}

--- 将颜色字符串转为 RGB 数组
--- @param color string # 形如 "#RRGGBB" 的颜色字符串
--- @return table # {r, g, b}
local function rgb(color)
	color = string.lower(color)
	return {
		tonumber(color:sub(2, 3), 16),
		tonumber(color:sub(4, 5), 16),
		tonumber(color:sub(6, 7), 16),
	}
end

--- 前景色与背景色混合，返回混合后的 HEX 颜色
--- @param foreground string # 前景色 HEX
--- @param alpha number|string # 混合比例 (0~1) 或 16进制字符串
--- @param background string # 背景色 HEX
--- @return string # 混合后的 HEX 颜色
function M.blend(foreground, alpha, background)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg, fg = rgb(background), rgb(foreground)
	local function blendChannel(i)
		return math.floor(math.min(math.max(0, alpha * fg[i] + (1 - alpha) * bg[i]), 255) + 0.5)
	end
	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

--- 判断主题类型（深色/浅色），并计算对比度等信息
--- @param bg_color string # 背景色 HEX
--- @param fg_color string # 前景色 HEX
--- @return table # { is_dark, contrast_ratio, background_luminance, foreground_luminance }
function M.detect_theme_type(bg_color, fg_color)
	local function complete_hex(hex)
		hex = hex:gsub("#", ""):lower()
		if #hex == 3 then
			hex = hex:gsub("(.)", "%1%1")
		end
		return "#" .. hex
	end

	local function safe_rgb(color)
		local ok, result = pcall(rgb, complete_hex(color))
		return ok and result or { 0, 0, 0 }
	end

	local bg = safe_rgb(bg_color)
	local bg_lum = 0.2126 * bg[1] + 0.7152 * bg[2] + 0.0722 * bg[3]

	local fg = safe_rgb(fg_color or "#ffffff")
	local fg_lum = 0.2126 * fg[1] + 0.7152 * fg[2] + 0.0722 * fg[3]

	return {
		is_dark = bg_lum < 128,
		contrast_ratio = (math.max(bg_lum, fg_lum) + 0.05) / (math.min(bg_lum, fg_lum) + 0.05),
		background_luminance = bg_lum,
		foreground_luminance = fg_lum,
	}
end

--- 获取当前操作系统类型，支持分发不同逻辑
--- @param handlers table|nil # 可选，系统分发表
--- @return string|unknown # 返回系统类型或分发结果
function M.get_os_type(handlers)
	local triple = require("wezterm").target_triple
	local sys
	if triple:find("darwin") then
		sys = "macos"
	elseif triple:find("windows") then
		sys = "windows"
	elseif triple:find("linux") then
		sys = "linux"
	else
		sys = "unknown"
	end

	if type(handlers) == "table" then
		local handler = handlers[sys] or handlers["default"]
		if type(handler) == "function" then
			return handler()
		else
			return handler
		end
	end

	return sys
end

return M
