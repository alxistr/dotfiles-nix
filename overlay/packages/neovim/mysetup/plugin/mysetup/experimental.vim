augroup fennelfiles
  au!
  au FileType fennel nnoremap <buffer> <localleader>lf :lua s.fnldo()<CR>
augroup END

augroup vimfiles
  au!
  au FileType vim nnoremap <buffer> <localleader>lf :source %<CR>
augroup END

" noremap <localleader>ll :lua print(vim.inspect(s.text))<CR>

" command! -nargs=+ FnlDo :lua s.fennel.eval(string(<q-args>))
" command! -nargs=+ Fnl :lua print(vim.inspect(string(<q-args>)))

" noremap <localleader>lf :lua evaltext()<CR>
" noremap <localleader>lk :lua evalline()<CR>
" noremap <localleader>ll :lua evalselected()<CR>

" augroup fennelfiles
"   au!
"   au FileType fennel nnoremap
"    \ <localleader>ll
"    \ :lua mysetup-exec-fennel
" augroup END




" " command -nargs=* Error luaeval(<args>)
"
" lua << END
"
" mysetup = {}
"
" mysetup.get_selected_text = function ()
"     f = vim.call('getpos', "'<"),
"     l = vim.call('getpos', "'>")
" end
"
" function testfn()
"   print(vim.inspect({
"     f = vim.call('getpos', "'<"),
"     l = vim.call('getpos', "'>")
"   }))
" end
"
"
" END
"
" vnoremap  <Leader>ll :lua testfn()<CR>
" nnoremap  <Leader>fnl :lua require('deps.fennel').dofile(vim.call('expand', '%'))<CR>
