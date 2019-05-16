function fish_dump_colors
    for i in (set -n | string match 'fish*_color*')
        echo "set $i $$i" 
    end
end 
