let g:airline#themes#custom#palette = {}

function! airline#themes#custom#refresh()
  let s:SL = airline#themes#get_highlight('StatusLine')
  let s:SLNC = airline#themes#get_highlight('StatusLineNC')
  if &background == "dark"
    let IA = [ '#666666', '#3A3A3A', 242, 235 ]
  else
    let IA = s:SLNC
  endif
  let g:airline#themes#custom#palette.normal = airline#themes#generate_color_map(s:SL, s:SL, s:SL)
  let g:airline#themes#custom#palette.insert = g:airline#themes#custom#palette.normal
  let g:airline#themes#custom#palette.replace = g:airline#themes#custom#palette.normal
  let g:airline#themes#custom#palette.visual = g:airline#themes#custom#palette.normal
  let g:airline#themes#custom#palette.normal.airline_error   = s:SLNC
  let g:airline#themes#custom#palette.normal.airline_warning = s:SLNC
  let g:airline#themes#custom#palette.normal.airline_term    = s:SL
  let g:airline#themes#custom#palette.inactive = airline#themes#generate_color_map(IA, IA, IA)
endfunction

call airline#themes#custom#refresh()
