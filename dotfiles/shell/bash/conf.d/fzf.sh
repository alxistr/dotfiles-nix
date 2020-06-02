# bind -x '"\C-r": READLINE_LINE=$(cat $HISTFILE | sort | uniq | fzf);READLINE_POINT=${#READLINE_LINE}'

if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi
