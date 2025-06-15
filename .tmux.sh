#!/bin/bash

CWD=$(pwd)
SESSION=$(basename "$CWD")

tmux new-session -d -s "$SESSION" -n editor -c "$CWD"
tmux send-keys -t "$SESSION:0" "hx ." C-m

tmux new-window -t "$SESSION:9" -n shell -c "$CWD"

tmux new-window -t "$SESSION:8" -n git -c "$CWD"
tmux send-keys -t "$SESSION:8" "lazygit" C-m

tmux new-window -t "$SESSION:7" -n lf -c "$CWD"
tmux send-keys -t "$SESSION:7" "lf" C-m

if [[ -f "$CWD/index.html" ]]; then
  tmux new-window -t "$SESSION:6" -n run -c "$CWD"
  tmux send-keys -t "$SESSION:6" "python -m http.server 8080" C-m
fi

if [[ -f "$CWD/package.json" ]]; then
  tmux new-window -t "$SESSION:6" -n run -c "$CWD"
  tmux send-keys -t "$SESSION:6" "npm run dev" C-m
fi

tmux select-window -t "$SESSION:0"

tmux attach -t "$SESSION"
