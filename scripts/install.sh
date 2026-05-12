#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
install_dir="${TMUX_MOBAXTERM_KIT_DIR:-$HOME/.tmux/mobaxterm-kit}"
target_conf="${TMUX_CONF_TARGET:-$HOME/.tmux.conf}"
backup_suffix="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$install_dir"

cp "$repo_root/tmux.conf" "$install_dir/tmux.conf"
cp "$repo_root/scripts/tmux-popup-menu.sh" "$install_dir/tmux-popup-menu.sh"
chmod +x "$install_dir/tmux-popup-menu.sh"

if [ -e "$target_conf" ] || [ -L "$target_conf" ]; then
  cp "$target_conf" "$target_conf.bak.$backup_suffix"
fi

cp "$install_dir/tmux.conf" "$target_conf"

echo "Installed tmux-mobaxterm-kit to $target_conf"
echo "Reload with: tmux source-file $target_conf"
