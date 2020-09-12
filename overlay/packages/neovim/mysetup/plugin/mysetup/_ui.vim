let g:airline_theme='custom'
let g:gruvbox_italics = 0
colorscheme gruvbox8
if $TERM=~'linux'
    set t_Co=16
else
    set t_Co=256
    set background=dark
    highlight SpecialKey ctermbg=none cterm=none ctermfg=DarkGray
    highlight NonText ctermbg=none cterm=none ctermfg=DarkGray
    highlight ColorColumn ctermbg=235 guibg=#FFC600
    highlight Conceal cterm=NONE ctermbg=NONE ctermfg=LightGray
endif
