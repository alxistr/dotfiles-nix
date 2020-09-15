au CursorHold * checktime

augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END

augroup trimfiles
  au!
  au FileType python,javascript,go,conf,vim,lua,erlang,clojure,nix au BufWritePre * %s/\s\+$//e
augroup END
