local wezterm = require('wezterm')

return {
    setup_fonts = function(wezterm_config)
        local fonts = _G.configs.fonts --[[ @type table ]]
        wezterm_config.font_size = _G.configs.font_size
        wezterm_config.font = wezterm.font_with_fallback({
            { family = fonts.main, weight = 'Regular' },
            { family = fonts.comment, weight = 'Regular' },
            table.unpack(fonts.fallback),
        })
        wezterm_config.font_rules = {
            {
                intensity = 'Bold',
                italic = false,
                font = wezterm.font_with_fallback({
                    { family = fonts.main, weight = 'Bold' },
                    table.unpack(fonts.fallback),
                }),
            },

            -- Bold-and-italic
            {
                intensity = 'Bold',
                italic = true,
                font = wezterm.font_with_fallback({
                    { family = fonts.main, weight = 'Bold', italic = true },
                    table.unpack(fonts.fallback),
                }),
            },

            -- Normal-intensity-and-italic
            {
                intensity = 'Normal',
                italic = true,
                font = wezterm.font_with_fallback({
                    { family = fonts.comment, weight = 'Regular', italic = true },
                    { family = fonts.main, weight = 'Bold', italic = true },
                    table.unpack(fonts.fallback),
                }),
            },

            -- Half-intensity-and-italic
            {
                intensity = 'Half',
                italic = true,
                font = wezterm.font_with_fallback({
                    { family = fonts.main, italic = true },
                    table.unpack(fonts.fallback),
                }),
            },

            -- Half-intensity-and-not-italic
            {
                intensity = 'Half',
                italic = false,
                font = wezterm.font_with_fallback({
                    { family = fonts.main },
                    table.unpack(fonts.fallback),
                }),
            },
        }
    end,
}
