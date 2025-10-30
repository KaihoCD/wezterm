# 🌈 WezTerm 终端配置

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

## 主要特性

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

## 快捷键一览

| 快捷键            | 功能描述                     |
| ----------------- | ---------------------------- |
| Leader + hjkl     | 分屏切换                     |
| Leader + H/L      | 标签页切换                   |
| Leader + <Number> | 切换到第 N 个标签页          |
| Leader + t        | 新建标签页                   |
| Leader + v/s      | 水平/垂直分屏                |
| Leader + w        | 关闭当前分屏/标签            |
| Leader + y        | 进入复制模式                 |
| Leader + p        | 粘贴剪贴板内容               |
| Leader + f        | 搜索                         |
| Leader + e        | 编辑配置目录（自动选编辑器） |
| Leader + =/-/0    | 快速调整字体大小             |

---

## 字体设置
- 主字体：JetBrainsMono Nerd Font
- 中文/符号/emoji字体：自动根据系统切换
  - macOS：PingFang SC、Apple Color Emoji、Symbols Nerd Font
  - Windows：Microsoft YaHei、Segoe UI Emoji、Symbols Nerd Font
  - Linux：WenQuanYi Micro Hei、Symbols Nerd Font

---

## 主题美化
- 默认主题：Tokyo Night
- 自动生成 tab 栏高亮、衍生色

---

## 状态栏与标签页
- 状态栏显示当前目录、设备名
- 标签页显示进程图标、进程名、序号

---

## 编辑配置目录
- Leader + e：自动检测 nvim/vim/code/open/explorer，优先选择可用编辑器打开配置目录

---

## 使用方法
1. 安装 [WezTerm](https://wezfurlong.org/wezterm/)
2. 克隆本仓库到 `~/.config/wezterm`
3. 启动 WezTerm 即可自动加载本配置

---

## License
MIT
