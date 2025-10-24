# 🌈 WezTerm 终端配置

> 高效 · 美观 · 多平台 · 极致定制

---

## 简介
本仓库是个人 WezTerm 终端配置，专为开发者和效率控打造，兼容 macOS、Windows、Linux，支持中英文字体自动切换，集成多种实用快捷键和美化主题。

---

## 主要特性

- 🟦 **主题美化**：默认 Tokyo Night，自动生成衍生色，tab 栏高亮美观
- 🟩 **智能字体**：JetBrainsMono Nerd Font 主字体，自动根据系统切换中文/emoji/符号字体
- 🟪 **多平台兼容**：macOS / Windows / Linux 一套配置全搞定
- 🟫 **快捷菜单**：Leader + e 一键打开配置目录，自动选择最佳编辑器（nvim/vim/code/open/explorer）
- 🟥 **Vim-like 操作**：Leader 键、Pane/Tab 快速切换、分屏、关闭等
- 🟨 **Tab/Pane 管理**：Leader + 数字切换标签，Leader + hjkl 切换分屏
- 🟧 **搜索/复制模式**：Leader + f 搜索，Leader + y 进入复制模式
- 🟦 **字体大小调节**：Leader + =/-/0 快速调整字体大小
- 🟩 **状态栏美化**：显示当前目录、设备名，tab 栏显示进程图标和序号
- 🟪 **禁用原生按键**：只保留自定义快捷键，极致个性化

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
