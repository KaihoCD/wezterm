# 🌈 WezTerm Config

A modern, modular, and cross-platform WezTerm configuration
for developers who value aesthetics, productivity, and persistent customization.

---

## ✨ Features

- 🎨 **Dynamic Themes**:
  - Default: Default Dark (base16)
  - One-key theme picker (`Leader + T`), dynamic color palette, tab highlights
- 📝 **Smart Fonts**:
  - JetBrainsMono Nerd Font main, OS-aware emoji/CJK fallback
- 💾 **Persistent Config Cache**:
  - Theme (or what you want) settings auto-cached to disk
- ⚡ **Hot Reload & One-Key Reset**:
  - `Leader + R` instantly resets config cache and reloads theme
- 💻 **Cross-Platform**:
  - macOS, Linux, Windows/WSL auto-detect, shell/env/path fixups
- ⌨️ **Intuitive Keybindings**:
  - Vim-like navigation, pane/tab management, clipboard, search,
    config folder jump
- 🪟 **Minimal UI**:
  - Centered content, slim padding, distraction-free window decorations
- 📊 **Status Bar & Tabs**:
  - Shows current directory, user, process icons, clear tab indices
- 🧩 **Modular Structure**:
  - All settings split by function for easy extension and maintenance

## 🗂️ Directory Structure

```txt
wezterm.lua           # Main entry, loads all modules
configs/
  ├─ settings.lua     # Default config: theme, font, shell, etc.
  ├─ cache.lua        # Persistent cache: save/load/init/clear
  └─ init.lua         # Read config, merge cache, mount ro global
colors.lua            # Theme palette, color config
fonts.lua             # Font rules, fallback logic
keys.lua              # Keybindings, leader, event triggers
events/
  ├─ init.lua         # Event handlers: theme, status, tab, cache
  └─ utils.lua        # Event utility functions
utils.lua             # OS/type/hex helpers, color blending
```

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
| 🅻 + R     | Reset config cache          |

_🅻 = Leader key (<kbd>Shift</kbd> + <kbd>Space</kbd>)_

## 💾 Persistent Config & Hot Reload

- **Auto-caches**:
  theme/font/shell to `~/.cache/wezterm.cache`
- **One-key reset**:
  `Leader + R` clears cache, restores defaults, and hot-reloads theme
- **Event-driven**:
  All config changes/side effects handled via WezTerm events for stability

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

- Edit `configs/settings.lua` for fonts, themes, shell
- Edit `keys.lua` for keybindings
- Edit `colors.lua`, `fonts.lua` for appearance
- Status bar/tab logic in `events/init.lua`
- Extend `configs/cache.lua` for more persistent options

---

## 📄 License

MIT
