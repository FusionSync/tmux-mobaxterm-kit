# tmux-mobaxterm-kit

[English](README.md) | [中文](README.zh-CN.md)

一个专门为在 MobaXterm 中使用 tmux 优化的实用配置。

这个项目的目标是让 tmux 在 MobaXterm 里更顺手：保留 tmux 鼠标能力，同时兼顾 MobaXterm 原生的 Shift 选中文字复制、右键快捷操作，以及更快的历史内容滚动。

## 功能特性

- 右键打开 tmux 快捷菜单，快速操作会话、窗口、面板、视图和布局
- 快捷执行左右分屏、上下分屏、关闭面板、最大化面板、切换窗口等常用动作
- 按住 `Shift` 可以继续使用 MobaXterm 原生文字选中和复制
- 按住 `Shift` 滚动鼠标滚轮，可以更快地上下浏览 tmux 历史内容
- 支持 tmux 复制模式下的鼠标选择、双击选词、三击选行
- 提高历史缓冲区大小，适合长时间运行命令和日志查看
- 附带可选的脚本式 popup 面板，适合喜欢完整弹窗菜单的用户

## 环境要求

- tmux 3.2 或更新版本
- MobaXterm，或其他兼容鼠标事件上报的终端
- Bash，用于可选安装脚本和 popup 脚本

查看 tmux 版本：

```bash
tmux -V
```

## 快速开始

克隆仓库：

```bash
git clone git@github.com:FusionSync/tmux-mobaxterm-kit.git
cd tmux-mobaxterm-kit
```

执行安装：

```bash
chmod +x scripts/install.sh
./scripts/install.sh
```

重新加载 tmux 配置：

```bash
tmux source-file ~/.tmux.conf
```

安装脚本会在覆盖前备份已有的 `~/.tmux.conf`，备份文件名类似 `~/.tmux.conf.bak.<timestamp>`。

## 手动安装

如果你希望手动安装：

```bash
cp tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
```

也可以保留你原来的 tmux 配置，只在原配置里引用本项目：

```tmux
source-file ~/tmux-mobaxterm-kit/tmux.conf
```

## 鼠标行为

| 操作 | 效果 |
| --- | --- |
| 在面板上点击右键 | 打开 tmux 快捷菜单 |
| 鼠标滚轮 | 进入 tmux 复制模式并滚动历史内容 |
| `Shift` + 鼠标滚轮 | 更快地滚动 tmux 历史内容 |
| `Shift` + 拖拽文字 | 使用 MobaXterm 原生选中和复制 |
| 复制模式下双击 | 选中并复制单词 |
| 复制模式下三击 | 选中并复制整行 |

## 右键菜单内容

默认右键菜单包含：

- 会话：新建会话、重命名会话
- 窗口：新建窗口、重命名窗口、选择窗口、上一个窗口、下一个窗口
- 面板：左右分屏、上下分屏、关闭面板、拆出面板、合并面板、移动面板、最大化/取消最大化
- 视图：复制模式、清空历史、重启面板、重启窗口
- 布局：水平均分、垂直均分、主面板在上、主面板在左、平铺

## 可选 Popup 面板

默认的 `tmux.conf` 使用 tmux 原生 `display-menu`，轻量、快速，也更贴近日常右键菜单体验。

如果你更喜欢完整的 popup 弹窗面板，可以安装脚本后把右键绑定改成：

```tmux
bind-key -T root MouseDown3Pane display-popup -E -w 42 -h 30 "$HOME/.tmux/mobaxterm-kit/tmux-popup-menu.sh"
```

脚本文件位置：

```text
scripts/tmux-popup-menu.sh
```

## MobaXterm 使用说明

MobaXterm 通常会在 tmux 开启鼠标模式时，仍然保留 `Shift` + 鼠标拖拽的原生选中文字能力。这个行为适合你想直接复制终端里显示出来的文本时使用。

如果点击右键时仍然弹出 MobaXterm 自己的菜单，而不是 tmux 菜单，需要检查 MobaXterm 的鼠标和右键设置。终端需要把右键鼠标事件发送给 tmux，本配置才能接管它。

## 配置文件

主配置文件：

```text
tmux.conf
```

关键默认配置：

```tmux
set -g mouse on
set -g history-limit 100000
setw -g mode-keys vi
set -s set-clipboard on
```

## 开源协议

MIT
