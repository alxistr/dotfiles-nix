let g:parinfer_mode = 'smart'
let g:parinfer_force_balance = 1

augroup parinfer-autoenable
  au!
  au FileType clojure,racket,lisp,scheme,hy,fennel ParinferOn
augroup END
