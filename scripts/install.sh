#!/usr/bin/env bash

set -euo pipefail

repo="${TMUX_MOBAXTERM_KIT_REPO:-FusionSync/tmux-mobaxterm-kit}"
ref="${TMUX_MOBAXTERM_KIT_REF:-main}"
base_url="${TMUX_MOBAXTERM_KIT_BASE_URL:-https://raw.githubusercontent.com/$repo/$ref}"
install_dir="${TMUX_MOBAXTERM_KIT_DIR:-$HOME/.tmux/mobaxterm-kit}"
target_conf="${TMUX_CONF_TARGET:-$HOME/.tmux.conf}"
backup_suffix="$(date +%Y%m%d-%H%M%S)"
source_path="${BASH_SOURCE[0]:-}"
repo_root=""

download_file() {
  local url
  local target

  url="$1"
  target="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$target"
    return
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -qO "$target" "$url"
    return
  fi

  echo "curl or wget is required to download tmux-mobaxterm-kit." >&2
  exit 1
}

if [ -n "$source_path" ] && [ -f "$source_path" ]; then
  candidate_root="$(cd "$(dirname "$source_path")/.." && pwd)"
  if [ -f "$candidate_root/tmux.conf" ] && [ -f "$candidate_root/scripts/tmux-popup-menu.sh" ]; then
    repo_root="$candidate_root"
  fi
fi

mkdir -p "$install_dir"

if [ -n "$repo_root" ]; then
  cp "$repo_root/tmux.conf" "$install_dir/tmux.conf"
  cp "$repo_root/scripts/tmux-popup-menu.sh" "$install_dir/tmux-popup-menu.sh"
else
  download_file "$base_url/tmux.conf" "$install_dir/tmux.conf"
  download_file "$base_url/scripts/tmux-popup-menu.sh" "$install_dir/tmux-popup-menu.sh"
fi

chmod +x "$install_dir/tmux-popup-menu.sh"

if [ -e "$target_conf" ] || [ -L "$target_conf" ]; then
  cp "$target_conf" "$target_conf.bak.$backup_suffix"
fi

cp "$install_dir/tmux.conf" "$target_conf"

echo "Installed tmux-mobaxterm-kit to $target_conf"
echo "Reload with: tmux source-file $target_conf"
