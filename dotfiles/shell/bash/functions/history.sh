bind -x '"\C-r": READLINE_LINE=$(cat $HISTFILE | sort | uniq | fzf);READLINE_POINT=${#READLINE_LINE}'
