function fish_mode_prompt
    echo -ne "┌─ "
    fish_default_mode_prompt
end

function fish_prompt
    powerline-rs --shell bare $status
    echo -ne "\n└─╼ "
end
