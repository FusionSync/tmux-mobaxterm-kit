#!/usr/bin/env bash

set -euo pipefail

tmux_cmd() {
  if [ -n "${TMUX:-}" ]; then
    tmux -S "${TMUX%%,*}" "$@"
  else
    tmux "$@"
  fi
}

choose() {
  local action
  action="$1"

  case "$action" in
    new-session)
      tmux_cmd command-prompt -p "新建会话:" "new-session -A -s '%%'"
      ;;
    rename-session)
      tmux_cmd command-prompt -I "#S" -p "重命名会话:" "rename-session -- '%%'"
      ;;
    new-window)
      tmux_cmd new-window
      ;;
    rename-window)
      tmux_cmd command-prompt -I "#W" -p "重命名窗口:" "rename-window -- '%%'"
      ;;
    choose-window)
      tmux_cmd choose-window
      ;;
    previous-window)
      tmux_cmd previous-window
      ;;
    next-window)
      tmux_cmd next-window
      ;;
    split-horizontal)
      tmux_cmd split-window -h
      ;;
    split-vertical)
      tmux_cmd split-window -v
      ;;
    kill-pane)
      tmux_cmd kill-pane
      ;;
    break-pane)
      tmux_cmd break-pane
      ;;
    join-pane)
      tmux_cmd choose-window 'join-pane -h -s "%%"'
      ;;
    swap-pane-up)
      tmux_cmd swap-pane -U
      ;;
    swap-pane-down)
      tmux_cmd swap-pane -D
      ;;
    toggle-zoom)
      tmux_cmd resize-pane -Z
      ;;
    copy-mode)
      tmux_cmd copy-mode
      ;;
    clear-history)
      tmux_cmd clear-history
      ;;
    respawn-pane)
      tmux_cmd respawn-pane -k
      ;;
    respawn-window)
      tmux_cmd respawn-window -k
      ;;
    layout-even-horizontal)
      tmux_cmd select-layout even-horizontal
      ;;
    layout-even-vertical)
      tmux_cmd select-layout even-vertical
      ;;
    layout-main-horizontal)
      tmux_cmd select-layout main-horizontal
      ;;
    layout-main-vertical)
      tmux_cmd select-layout main-vertical
      ;;
    layout-tiled)
      tmux_cmd select-layout tiled
      ;;
    *)
      return 1
      ;;
  esac
}

if [ "${1:-}" = "--run" ]; then
  choose "${2:-}"
  exit 0
fi

menu_content() {
  cat <<'MENU'
tmux 弹窗菜单

会话
  [S] 新建会话
  [R] 重命名会话

窗口
  [N] 新建窗口
  [W] 选择窗口
  [P] 上一个窗口
  [F] 下一个窗口
  [E] 重命名窗口

面板
  [H] 左右分屏
  [V] 上下分屏
  [X] 关闭面板
  [B] 拆出面板
  [J] 合并面板
  [U] 面板上移
  [D] 面板下移
  [Z] 最大化 / 取消最大化

视图
  [C] 复制模式
  [L] 清空历史
  [Q] 重启面板
  [T] 重启窗口

布局
  [1] 水平均分
  [2] 垂直均分
  [3] 主面板在上
  [4] 主面板在左
  [5] 平铺

按对应快捷键执行，或按 q / Esc 关闭。
MENU
}

render() {
  printf '\033[H\033[2J'
  menu_content
}

trap 'exit 0' INT TERM

render

while IFS= read -rsn1 key; do
  case "$key" in
    S|s) choose new-session; break ;;
    R|r) choose rename-session; break ;;
    N|n) choose new-window; break ;;
    W|w) choose choose-window; break ;;
    P|p) choose previous-window; break ;;
    F|f) choose next-window; break ;;
    E|e) choose rename-window; break ;;
    H|h) choose split-horizontal; break ;;
    V|v) choose split-vertical; break ;;
    X|x) choose kill-pane; break ;;
    B|b) choose break-pane; break ;;
    J|j) choose join-pane; break ;;
    U|u) choose swap-pane-up; break ;;
    D|d) choose swap-pane-down; break ;;
    Z|z) choose toggle-zoom; break ;;
    C|c) choose copy-mode; break ;;
    L|l) choose clear-history; break ;;
    Q) choose respawn-pane; break ;;
    T|t) choose respawn-window; break ;;
    1) choose layout-even-horizontal; break ;;
    2) choose layout-even-vertical; break ;;
    3) choose layout-main-horizontal; break ;;
    4) choose layout-main-vertical; break ;;
    5) choose layout-tiled; break ;;
    $'\e'|q) break ;;
  esac
done
