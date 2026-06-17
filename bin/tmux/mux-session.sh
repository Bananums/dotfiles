#!/usr/bin/env bash

SEARCH_DIRS=(~/git ~/projects)

# Use argument directly or fuzzy-find
if [[ $# -eq 1 ]]; then
  selected="$1"
else
  selected=$(find "${SEARCH_DIRS[@]}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | fzf)
fi

[[ -z $selected ]] && exit 0

selected=$(cd "$selected" && pwd)
session_name=$(basename "$selected" | tr . _)

setup_layout() {
  local session="$1"
  local dir="$2"

  # Do all splits and resizing first so nvim starts at the correct size
  tmux split-window -h -t "$session:1.1" -c "$dir"
  tmux split-window -v -t "$session:1.2" -c "$dir"
  tmux resize-pane -t "$session:1.1" -x "60%"

  sleep 1 #TODO Deal with the sleep hack to make nvim launch properly
  tmux send-keys -t "$session:1.1" "nvim ." Enter
  tmux send-keys -t "$session:1.2" "claude" Enter

  tmux select-pane -t "$session:1.1"
}

create_session() {
  tmux new-session -d -s "$session_name" -c "$selected"
  setup_layout "$session_name" "$selected"
}

if [[ -n $TMUX ]]; then
  if ! tmux has-session -t "$session_name" 2>/dev/null; then
    create_session
  fi
  tmux switch-client -t "$session_name"
else
  if ! tmux has-session -t "$session_name" 2>/dev/null; then
    create_session
  fi
  tmux attach -t "$session_name"
fi
