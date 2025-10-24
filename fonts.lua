local wezterm = require("wezterm")

return {
	setup_fonts = function(wezterm_config)
		local fonts = _G.configs.fonts --[[ @type table ]]
		wezterm_config.font_size = _G.configs.font_size
		wezterm_config.font = wezterm.font_with_fallback({
			{ family = fonts.main, weight = "DemiBold" },
			{ family = fonts.comment, weight = "DemiBold" },
			table.unpack(fonts.fallback),
		})
		wezterm_config.font_rules = {
			{
				intensity = "Bold",
				italic = false,
				font = wezterm.font_with_fallback({
					{ family = fonts.main, weight = "ExtraBold" },
					table.unpack(fonts.fallback),
				}),
			},

			-- Bold-and-italic
			{
				intensity = "Bold",
				italic = true,
				font = wezterm.font_with_fallback({
					{ family = fonts.main, weight = "ExtraBold", italic = true },
					table.unpack(fonts.fallback),
				}),
			},

			-- normal-intensity-and-italic
			{
				intensity = "Normal",
				italic = true,
				font = wezterm.font_with_fallback({
					{ family = fonts.comment, weight = "Regular", italic = true },
					{ family = fonts.main, weight = "ExtraBold", italic = true },
					table.unpack(fonts.fallback),
				}),
			},

			-- half-intensity-and-italic
			{
				intensity = "Half",
				italic = true,
				font = wezterm.font_with_fallback({
					{ family = fonts.main, italic = true },
					table.unpack(fonts.fallback),
				}),
			},

			-- half-intensity-and-not-italic
			{
				intensity = "Half",
				italic = false,
				font = wezterm.font_with_fallback({
					{ family = fonts.main },
					table.unpack(fonts.fallback),
				}),
			},
		}
	end,
}
