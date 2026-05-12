# tmux-mobaxterm-kit

[English](README.md) | [中文](README.zh-CN.md)

A practical tmux configuration optimized for running tmux inside MobaXterm.

It keeps tmux mouse support enabled while preserving the MobaXterm habits that make daily terminal work fast: right-click actions, Shift-based native text selection, and accelerated scrollback navigation.

## Features

- Right-click tmux menu for common session, window, pane, view, and layout actions
- One-click pane splitting, pane closing, pane zooming, window switching, and layout changes
- Hold `Shift` to use MobaXterm native text selection and copy
- Hold `Shift` and scroll the wheel to move through tmux history faster
- Mouse selection inside tmux copy mode with word and line selection support
- Large scrollback history limit for long-running terminal sessions
- Optional script-based popup menu for users who prefer a full popup panel

## Requirements

- tmux 3.2 or newer
- MobaXterm, or another terminal with compatible mouse reporting
- Bash for the optional installer and popup script

Check your tmux version:

```bash
tmux -V
```

## Quick Start

Clone the repository:

```bash
git clone git@github.com:FusionSync/tmux-mobaxterm-kit.git
cd tmux-mobaxterm-kit
```

Install the configuration:

```bash
chmod +x scripts/install.sh
./scripts/install.sh
```

Reload tmux:

```bash
tmux source-file ~/.tmux.conf
```

The installer backs up an existing `~/.tmux.conf` to `~/.tmux.conf.bak.<timestamp>` before replacing it.

## Manual Install

If you prefer to install manually:

```bash
cp tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
```

You can also keep your current tmux config and source this kit from it:

```tmux
source-file ~/tmux-mobaxterm-kit/tmux.conf
```

## Mouse Behavior

| Action | Behavior |
| --- | --- |
| Right click a pane | Open the tmux action menu |
| Scroll wheel | Enter tmux copy mode and scroll history |
| `Shift` + scroll wheel | Scroll tmux history faster |
| `Shift` + drag text | Use MobaXterm native selection and copy |
| Double click in copy mode | Select and copy a word |
| Triple click in copy mode | Select and copy a line |

## Right-Click Menu

The default right-click menu includes:

- Session: new session, rename session
- Window: new window, rename window, choose window, previous/next window
- Pane: split left/right, split top/bottom, kill pane, break pane, join pane, move pane, zoom/unzoom
- View: copy mode, clear history, respawn pane, respawn window
- Layout: even horizontal, even vertical, main horizontal, main vertical, tiled

## Optional Popup Panel

The default `tmux.conf` uses tmux's native `display-menu`, which is fast and lightweight.

If you prefer a larger popup panel, install the scripts and bind right click to `display-popup` instead:

```tmux
bind-key -T root MouseDown3Pane display-popup -E -w 42 -h 30 "$HOME/.tmux/mobaxterm-kit/tmux-popup-menu.sh"
```

The popup script is available at:

```text
scripts/tmux-popup-menu.sh
```

## MobaXterm Notes

MobaXterm usually reserves `Shift` + mouse drag for native terminal selection even when tmux mouse mode is enabled. This is useful when you want to copy text exactly as it appears in the terminal.

If right click still opens a MobaXterm context menu instead of the tmux menu, check your MobaXterm mouse and right-click settings. The terminal must send right-click mouse events to tmux for this configuration to handle them.

## Configuration

The main configuration file is:

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

## License

MIT
