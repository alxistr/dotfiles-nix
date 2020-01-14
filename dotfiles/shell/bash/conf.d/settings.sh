function lqp () {
  source ~/.config/bash/liquidprompt/liquidprompt
}

if [[ -z $IN_NIX_SHELL ]]; then
  lqp
fi

# eval "$(direnv hook bash)"

# prompt() {
#   PS1="┌─ $(powerline-rs --shell bash $?)\n└─╼ "
# }
# PROMPT_COMMAND=prompt
