<div align="center">

# tmux-mobaxterm-kit

**为 MobaXterm 优化的 tmux 配置：右键菜单、Shift 原生复制、快速滚动历史内容。**

<p>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/github/license/FusionSync/tmux-mobaxterm-kit?style=for-the-badge"></a>
  <img alt="tmux 3.2+" src="https://img.shields.io/badge/tmux-3.2%2B-1BB91F?style=for-the-badge&logo=tmux&logoColor=white">
  <img alt="Bash installer" src="https://img.shields.io/badge/bash-installer-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white">
  <img alt="MobaXterm ready" src="https://img.shields.io/badge/MobaXterm-ready-0078D4?style=for-the-badge&logo=windowsterminal&logoColor=white">
</p>

<p>
  <a href="README.md">English</a>
  ·
  <a href="#安装">安装</a>
  ·
  <a href="#鼠标映射">鼠标映射</a>
  ·
  <a href="#自定义">自定义</a>
</p>

</div>

## 安装

直接复制执行：

```bash
curl -fsSL https://raw.githubusercontent.com/FusionSync/tmux-mobaxterm-kit/main/scripts/install.sh | bash
```

如果你更喜欢 `wget`：

```bash
wget -qO- https://raw.githubusercontent.com/FusionSync/tmux-mobaxterm-kit/main/scripts/install.sh | bash
```

安装后重新加载 tmux 配置：

```bash
tmux source-file ~/.tmux.conf
```

安装脚本会在覆盖前备份已有的 `~/.tmux.conf`，备份文件名类似 `~/.tmux.conf.bak.<timestamp>`。

## 你会得到什么

| 功能 | 效果 |
| --- | --- |
| 右键 tmux 菜单 | 快速分屏、切窗口、重命名、关闭、最大化、切换布局 |
| MobaXterm 原生选中 | 按住 `Shift` 拖拽，继续用 MobaXterm 选中文字和复制 |
| 快速滚动历史 | 按住 `Shift` 滚轮，更快浏览 tmux 历史内容 |
| 鼠标复制模式 | 滚动进入历史、选中文字、双击选词、三击选行 |
| 不依赖插件管理器 | 一个 `tmux.conf` 加上可选辅助脚本即可使用 |

## 鼠标映射

| 操作 | 效果 |
| --- | --- |
| 在面板上点击右键 | 打开 tmux 快捷菜单 |
| 鼠标滚轮 | 进入 tmux 复制模式并滚动历史内容 |
| `Shift` + 鼠标滚轮 | 更快地滚动 tmux 历史内容 |
| `Shift` + 拖拽文字 | 使用 MobaXterm 原生选中和复制 |
| 复制模式下双击 | 选中并复制单词 |
| 复制模式下三击 | 选中并复制整行 |

## 右键菜单

默认右键菜单使用 tmux 原生 `display-menu`，包含：

| 分组 | 操作 |
| --- | --- |
| 会话 | 新建会话、重命名会话 |
| 窗口 | 新建窗口、重命名窗口、选择窗口、上一个窗口、下一个窗口 |
| 面板 | 左右分屏、上下分屏、关闭面板、拆出面板、合并面板、移动面板、最大化/取消最大化 |
| 视图 | 复制模式、清空历史、重启面板、重启窗口 |
| 布局 | 水平均分、垂直均分、主面板在上、主面板在左、平铺 |

## 环境要求

- tmux 3.2 或更新版本
- MobaXterm，或其他兼容鼠标事件上报的终端
- Bash，以及 `curl` 或 `wget`

查看 tmux 版本：

```bash
tmux -V
```

## 自定义

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

如果你已经有自己的 tmux 配置，可以在原配置中引用本项目，而不是直接替换：

```tmux
source-file ~/.tmux/mobaxterm-kit/tmux.conf
```

## 可选 Popup 面板

默认配置使用 `display-menu`，因为它轻量、快速，也更像日常右键菜单。

如果你更喜欢完整的 popup 弹窗面板，可以在安装后把右键绑定改成：

```tmux
bind-key -T root MouseDown3Pane display-popup -E -w 42 -h 30 "$HOME/.tmux/mobaxterm-kit/tmux-popup-menu.sh"
```

## 本地安装

适合开发、修改或先审查代码：

```bash
git clone git@github.com:FusionSync/tmux-mobaxterm-kit.git
cd tmux-mobaxterm-kit
./scripts/install.sh
```

如果你想先查看远程安装脚本再执行：

```bash
curl -fsSL https://raw.githubusercontent.com/FusionSync/tmux-mobaxterm-kit/main/scripts/install.sh -o /tmp/tmux-mobaxterm-kit-install.sh
less /tmp/tmux-mobaxterm-kit-install.sh
bash /tmp/tmux-mobaxterm-kit-install.sh
```

## MobaXterm 使用说明

MobaXterm 通常会在 tmux 开启鼠标模式时，仍然保留 `Shift` + 鼠标拖拽的原生选中文字能力。这个行为适合你想直接复制终端里显示出来的文本时使用。

如果点击右键时仍然弹出 MobaXterm 自己的菜单，而不是 tmux 菜单，需要检查 MobaXterm 的鼠标和右键设置。终端需要把右键鼠标事件发送给 tmux，本配置才能接管它。

## 开源协议

MIT
