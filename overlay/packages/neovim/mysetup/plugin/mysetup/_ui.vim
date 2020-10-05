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
  hi CursorColumn ctermbg=229 guibg=Grey90
  hi CursorLine ctermbg=229 guibg=Grey90
  hi CursorLineNr ctermfg=172 ctermbg=229 gui=bold guifg=Brown
  " hi CursorLine ctermbg=231 guibg=Grey90
  " hi CursorLineNr ctermfg=172 ctermbg=231 gui=bold guifg=Brown
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
  nnoremap <silent> <Leader>ttt :call ToggleTheme()<CR>
  nnoremap <silent> <Leader>ttd :call EnableDarkTheme()<CR>
  nnoremap <silent> <Leader>ttl :call EnableLightTheme()<CR>
augroup END

au VimEnter * call EnableDarkTheme()
