<div align="center">

# tmux-mobaxterm-kit

**A MobaXterm-friendly tmux setup with right-click menus, Shift copy, and fast scrollback.**

<p>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/github/license/FusionSync/tmux-mobaxterm-kit?style=for-the-badge"></a>
  <img alt="tmux 3.2+" src="https://img.shields.io/badge/tmux-3.2%2B-1BB91F?style=for-the-badge&logo=tmux&logoColor=white">
  <img alt="Bash installer" src="https://img.shields.io/badge/bash-installer-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white">
  <img alt="MobaXterm ready" src="https://img.shields.io/badge/MobaXterm-ready-0078D4?style=for-the-badge&logo=windowsterminal&logoColor=white">
</p>

<p>
  <a href="README.zh-CN.md">中文</a>
  ·
  <a href="#install">Install</a>
  ·
  <a href="#mouse-map">Mouse Map</a>
  ·
  <a href="#customize">Customize</a>
</p>

</div>

## Install

Paste this into your shell:

```bash
curl -fsSL https://raw.githubusercontent.com/FusionSync/tmux-mobaxterm-kit/main/scripts/install.sh | bash
```

Prefer `wget`?

```bash
wget -qO- https://raw.githubusercontent.com/FusionSync/tmux-mobaxterm-kit/main/scripts/install.sh | bash
```

Reload tmux after installation:

```bash
tmux source-file ~/.tmux.conf
```

The installer backs up an existing `~/.tmux.conf` to `~/.tmux.conf.bak.<timestamp>` before replacing it.

## What You Get

| Feature | Result |
| --- | --- |
| Right-click tmux menu | Split panes, switch windows, rename, kill, zoom, and change layouts quickly |
| MobaXterm native selection | Hold `Shift` and drag to select/copy text with MobaXterm |
| Fast tmux scrollback | Hold `Shift` and scroll the wheel to move through history faster |
| Mouse copy mode | Scroll into history, select text, double-click words, triple-click lines |
| No plugin manager required | A single `tmux.conf` plus optional helper scripts |

## Mouse Map

| Action | Behavior |
| --- | --- |
| Right click a pane | Open the tmux action menu |
| Scroll wheel | Enter tmux copy mode and scroll history |
| `Shift` + scroll wheel | Scroll tmux history faster |
| `Shift` + drag text | Use MobaXterm native selection and copy |
| Double click in copy mode | Select and copy a word |
| Triple click in copy mode | Select and copy a line |

## Right-Click Menu

The default right-click menu is powered by tmux's native `display-menu` and includes:

| Group | Actions |
| --- | --- |
| Session | New session, rename session |
| Window | New window, rename window, choose window, previous/next window |
| Pane | Split left/right, split top/bottom, kill pane, break pane, join pane, move pane, zoom/unzoom |
| View | Copy mode, clear history, respawn pane, respawn window |
| Layout | Even horizontal, even vertical, main horizontal, main vertical, tiled |

## Requirements

- tmux 3.2 or newer
- MobaXterm, or another terminal with compatible mouse reporting
- Bash, plus either `curl` or `wget` for the remote installer

Check your tmux version:

```bash
tmux -V
```

## Customize

The main configuration lives in:

```text
tmux.conf
```

Important defaults:

```tmux
set -g mouse on
set -g history-limit 100000
setw -g mode-keys vi
set -s set-clipboard on
```

If you already maintain your own tmux config, source this kit instead of replacing your file:

```tmux
source-file ~/.tmux/mobaxterm-kit/tmux.conf
```

## Optional Popup Panel

The default setup uses `display-menu` because it is fast and lightweight.

If you prefer a larger popup panel, bind right click to the helper script after installing:

```tmux
bind-key -T root MouseDown3Pane display-popup -E -w 42 -h 30 "$HOME/.tmux/mobaxterm-kit/tmux-popup-menu.sh"
```

## Local Checkout

For development or manual review:

```bash
git clone git@github.com:FusionSync/tmux-mobaxterm-kit.git
cd tmux-mobaxterm-kit
./scripts/install.sh
```

You can inspect the remote installer before running it:

```bash
curl -fsSL https://raw.githubusercontent.com/FusionSync/tmux-mobaxterm-kit/main/scripts/install.sh -o /tmp/tmux-mobaxterm-kit-install.sh
less /tmp/tmux-mobaxterm-kit-install.sh
bash /tmp/tmux-mobaxterm-kit-install.sh
```

## MobaXterm Notes

MobaXterm usually reserves `Shift` + mouse drag for native terminal selection even when tmux mouse mode is enabled. This is useful when you want to copy text exactly as it appears in the terminal.

If right click still opens a MobaXterm context menu instead of the tmux menu, check your MobaXterm mouse and right-click settings. The terminal must send right-click mouse events to tmux for this configuration to handle them.

## License

MIT
