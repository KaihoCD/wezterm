local get_os_type = require("utils").get_os_type

return {
	themes = "Tokyo Night",
	font_size = get_os_type({
		macos = 14,
		windows = 10,
		linux = 12,
	}),
	fonts = {
		main = "JetBrainsMono Nerd Font",
		comment = "JetBrainsMono Nerd Font",
		fallback = get_os_type({
			macos = { "PingFang SC", "Apple Color Emoji", "Symbols Nerd Font" },
			windows = { "Microsoft YaHei", "Segoe UI Emoji", "Symbols Nerd Font" },
			linux = { "WenQuanYi Micro Hei", "Symbols Nerd Font" },
		}),
	},
	shell = get_os_type({
		macos = { "zsh", "-l" },
		windows = { "pwsh", "-l" },
		linux = { "zsh", "-l" },
	}),
}
