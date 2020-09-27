augroup fennelfiles
  au!
  au FileType fennel nnoremap <buffer> <localleader>lf :FnlFile<CR>
augroup END

augroup vimfiles
  au!
  au FileType vim nnoremap <buffer> <localleader>lf :source %<CR>
augroup END

command! -nargs=1 Fnl :lua fnleval(<f-args>)
command! -nargs=? -complete=file FnlFile :Fnl (fnlfile <f-args>)
