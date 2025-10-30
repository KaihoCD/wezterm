local wezterm = require('wezterm')
local utils = require('utils')

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
    return { bg_color = bg, fg_color = fg, intensity = 'Bold' }
end

--- 生成 wezterm 颜色相关配置对象
--- @param theme_name string 主题名
--- @return {color_scheme: string, window_frame: table, colors: table}
local function make_color_config(theme_name)
    local colors = gen_theme_palette(theme_name)
    return {
        color_scheme = theme_name,
        window_frame = {
            inactive_titlebar_bg = colors.dark_bg,
            active_titlebar_bg = colors.dark_bg,
        },
        colors = {
            tab_bar = {
                active_tab = gen_config(colors.bg, colors.fg),
                inactive_tab = gen_config(colors.dark_bg, colors.light_fg),
                inactive_tab_edge = colors.light_fg,
                inactive_tab_hover = gen_config(colors.bg, colors.light_fg),
                new_tab = gen_config(colors.dark_bg, colors.light_fg),
                new_tab_hover = gen_config(colors.dark_bg, colors.fg),
            },
        },
    }
end

return {
    get_colors = function()
        return gen_theme_palette(_G.configs.themes)
    end,
    setup_colors = function(wezterm_config)
        local conf = make_color_config(_G.configs.themes)
        wezterm_config.color_scheme = conf.color_scheme
        wezterm_config.window_frame = conf.window_frame
        wezterm_config.colors = conf.colors
    end,
    make_color_config = make_color_config,
}
