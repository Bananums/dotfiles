#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false

create_symlink(){
  local source="$1"
  local dest="$2"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    local timestamp=$(date +%Y-%m-%dT%H-%M-%S)
    echo "Found $dest and is not a symlink. Creating backup $dest.bak-$timestamp"
    if $DRY_RUN; then
      echo "mv $dest $dest.bak-$timestamp"
    else
      mv "$dest" "$dest.bak-$timestamp"
    fi
  fi

  if $DRY_RUN; then
    echo "ln -sfn $source $dest"
  else
    ln -sfn "$source" "$dest"
  fi
}

remove_symlink(){
  local dest="$1"
  if $DRY_RUN; then
    echo "unlink $dest"
  else
    unlink "$dest"
  fi
}

symlink_argument() {
  local topics=("$@")
  echo "Creating Symlink of configs"
  for topic in "${topics[@]}"; do
    create_symlink "$DOTFILES_DIR/$topic" "$HOME/.config/$topic"
  done
}

unlink_argument() {
  local topics=("$@")
  echo "Removing Symlink of configs"
  for topic in "${topics[@]}"; do
    remove_symlink "$HOME/.config/$topic"
  done
}

unknown_argument(){
  local action="$1"
  echo "Unknown action: $action"
  show_help
  exit 1
}

show_help() {
  cat <<EOF
Usage: install.sh [action] [--dry-run]

Actions:
  symlink    Create symlinks for all topics in ~/.config (default)
  unlink     Remove symlinks for all topics in ~/.config

Flags:
  --dry-run  Print what would happen without making changes
  -h, --help Show this help message
EOF
}

main() {
  local action="symlink"
  local topics=(ghostty gtk-3.0 hypr i3 kitty nvim picom polybar rofi tmux waybar wofi wallpapers)

  for arg in "$@"; do
    case "$arg" in
      --dry-run)
        DRY_RUN=true
        ;;
      -h|--help)
        show_help
        exit 0
        ;;
      symlink|unlink)
        action="$arg"
        ;;
      *)
        unknown_argument "$arg"
        ;;
    esac
  done

  case "$action" in
    symlink)
      symlink_argument "${topics[@]}"
      ;;
    unlink)
      unlink_argument "${topics[@]}"
      ;;
  esac
}

main "$@"