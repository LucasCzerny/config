#!/bin/bash

CWD=$(pwd)
SESSION=$(basename "$CWD")

# Start session and window 1: editor
tmux new-session -d -s "$SESSION" -n editor -c "$CWD"
tmux send-keys -t "$SESSION:1" "hx ." C-m

# Window 2: shell
tmux new-window -t "$SESSION:2" -n shell -c "$CWD"

# Window 3: git
tmux new-window -t "$SESSION:3" -n git -c "$CWD"
tmux send-keys -t "$SESSION:3" "lazygit" C-m

# Optional window 4: run (if index.html or package.json exists)
if [[ -f "$CWD/index.html" ]]; then
  tmux new-window -t "$SESSION:4" -n run -c "$CWD"
  tmux send-keys -t "$SESSION:4" "python -m http.server 8080" C-m
fi

# Focus back to editor (window 1)
tmux select-window -t "$SESSION:1"

# Attach
tmux attach -t "$SESSION"
