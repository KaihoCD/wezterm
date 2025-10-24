local wezterm = require("wezterm")
local utils = require("utils")

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

local function gen_config(bg, fg)
	return { bg_color = bg, fg_color = fg, intensity = "Bold" }
end

local colors = gen_theme_palette(_G.configs.themes)

return {
    colors = colors,
    setup_colors = function (wezterm_config)
        wezterm_config.color_scheme = _G.configs.themes
        wezterm_config.window_frame = {
            inactive_titlebar_bg = colors.dark_bg,
            active_titlebar_bg = colors.dark_bg,
        }
        wezterm_config.colors = {
            tab_bar = {
                active_tab = gen_config(colors.bg, colors.fg),
                inactive_tab = gen_config(utils.blend(colors.dark_bg, 0.5, colors.bg), colors.light_fg),
                inactive_tab_edge = colors.light_fg,
                inactive_tab_hover = gen_config(colors.bg, colors.light_fg),
                new_tab = gen_config(colors.dark_bg, colors.light_fg),
                new_tab_hover = gen_config(colors.dark_bg, colors.fg),
            },
        }
    end
}