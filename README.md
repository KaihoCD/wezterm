# 🌈 WezTerm Config

A clean, modern, and cross-platform WezTerm configuration
for developers who want great looks,
productivity, and sensible defaults.

---

## ✨ Features

- 🎨 **Beautiful Themes**:
  Tokyo Night by default, with dynamic color palette and tab highlights.
- 📝 **Smart Fonts**:
  JetBrainsMono Nerd Font as main font,
  with automatic fallback for CJK and emoji per OS.
- 💻 **Cross-Platform**:
  Works out-of-the-box on macOS, Linux, and Windows.
- ⌨️ **Intuitive Keybindings**:
  Vim-like navigation, pane/tab management, and clipboard shortcuts.
- 🪟 **Minimal UI**:
  Centered content, slim padding, and distraction-free window decorations.
- 📊 **Status Bar & Tabs**:
  Shows current directory, user, and process icons with clear tab indices.
- ⚙️ **One-Config Setup**:
  All settings modularized for easy tweaking and extension.

---

## ⌨️ Key Bindings

| Shortcut  | Action                      |
| --------- | --------------------------- |
| 🅻 + hjkl  | Move between panes          |
| 🅻 + H/L   | Switch tabs                 |
| 🅻 + [1-9] | Go to tab N                 |
| 🅻 + t     | New tab                     |
| 🅻 + v/s   | Split pane (vertical/horiz) |
| 🅻 + w     | Close pane/tab              |
| 🅻 + y     | Copy mode                   |
| 🅻 + p     | Paste clipboard             |
| 🅻 + f     | Search                      |
| 🅻 + e     | Open config folder          |
| 🅻 + =/-/0 | Font size + / - / reset     |
| 🅻 + T     | Theme picker                |

_🅻 = Leader key (<kbd>Shift</kbd> + <kbd>Space</kbd>)_

---

## 🖋️ Fonts

- **Main**: JetBrainsMono Nerd Font
- **Fallbacks**:
  - 🍏 macOS: PingFang SC, Apple Color Emoji, Symbols Nerd Font
  - 🪟 Windows: Microsoft YaHei, Segoe UI Emoji, Symbols Nerd Font
  - 🐧 Linux: WenQuanYi Micro Hei, Symbols Nerd Font

---

## 🚀 How to Use

1. 📥 Install [WezTerm](https://wezfurlong.org/wezterm/)
2. 🗂️ Clone this repo to `~/.config/wezterm`
3. ▶️ Launch WezTerm — all settings are auto-loaded

---

## 🛠️ Customization

- Tweak `settings.lua` for fonts, themes, and shell.
- Edit `keys.lua` for keybindings.
- Adjust `colors.lua` and `fonts.lua` for appearance.
- Status bar and tab logic in `events/init.lua`.

---

## 📄 License

MIT
