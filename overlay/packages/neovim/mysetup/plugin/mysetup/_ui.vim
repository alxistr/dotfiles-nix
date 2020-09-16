let g:airline_theme = 'custom'
let g:gruvbox_italics = 0
let g:gruvbox_bold = 1

function EnableDarkTheme()
  set background=dark
  colorscheme gruvbox8_hard
endfunction

function EnableLightTheme()
  set background=light
  colorscheme gruvbox8
endfunction

function ToggleTheme()
  if &background ==# 'dark'
    call EnableLightTheme()
  else
    call EnableDarkTheme()
  endif
endfunction

augroup colorfixes
  au!
  au WinNew * set nocursorline nocursorcolumn
  nnoremap <Leader>ttt :call ToggleTheme()<CR>
  nnoremap <Leader>ttd :call EnableDarkTheme()<CR>
  nnoremap <Leader>ttl :call EnableLightTheme()<CR>
augroup END

au VimEnter * call EnableDarkTheme()
