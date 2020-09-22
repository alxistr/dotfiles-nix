function tmux-kill-all-clients () {
  tmux list-clients | \
  cut -d':' -f1 | \
  xargs -n1 tmux detach-client -t
}
