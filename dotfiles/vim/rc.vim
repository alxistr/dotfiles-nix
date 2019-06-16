if has('nvim')
    " set termguicolors
endif

"
"
"
"
"
"

set nu
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:·,space:·,trail:␠,extends:⟩,precedes:⟨
set list
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
set mouse=a
set incsearch
set colorcolumn=80
set tags=tags
set foldmethod=indent
set nofoldenable
" set clipboard+=unnamed
set clipboard+=unnamedplus
set nowrap
set completeopt-=preview

set autoread
au CursorHold * checktime


"
"
"
"
"
"

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_theme='base16_eighties'
" let g:airline_theme='cobalt2'
let g:airline_theme='wombat'

" let g:UltiSnipsExpandTrigger="<Leader>s"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" let g:ale_set_highlights = 0
" let g:ale_sign_error = 'E'
" let g:ale_sign_warning = 'W'

let g:sexp_enable_insert_mode_mappings = 0

let g:vim_parinfer_filetypes = ['clojure', 'racket', 'lisp', 'scheme', 'hy']
let g:vim_parinfer_globs = ['*.clj', '*.cljs', '*.cljc', '*.edn', '*.hl', '*.lisp', '*.rkt', '*.ss', '*.hy']

let g:hy_enable_conceal = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 0

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'

let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0

let g:magit_default_show_all_files = 0
let g:magit_default_fold_level = 0

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

function! s:close_buffers(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    echo val
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-f': 'bdelete!',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

"autocmd FileType python highlight ColorColumn ctermbg=235 " подсветка ограничительной колонки
autocmd FileType python,javascript,go,conf,vim,lua,erlang,clojure autocmd BufWritePre * %s/\s\+$//e " трим строк перед сохранением

augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END


"
"
"
"
"
"

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

let mapleader = " "

vmap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+yg_
nnoremap <Leader>y "+y
nnoremap <Leader>yy "+yy
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

noremap <silent> <C-l> :noh<CR><C-l>
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-h> <Left>
imap <M-l> <Right>

nnoremap <silent> <M-h> zC
nnoremap <silent> <M-s> zO
nnoremap <silent> <C-M-h> zM
nnoremap <silent> <C-M-s> zR

let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR><C-w>L
nnoremap <Leader>gc :Gcommit<CR><C-w>L
nnoremap <Leader>gi :Git rebase -i<CR>
nnoremap <Leader>gbl :Gblame<CR>
" nnoremap <Leader>gf :Git fetch<CR>
" nnoremap <Leader>gbr :Git branch<Space>
" nnoremap <Leader>go :Git checkout<Space>
" nnoremap <Leader>grs :Git push<CR>
" nnoremap <Leader>grl :Git pull<CR>

nnoremap <Leader>fs :w<CR>
nnoremap <Leader>fm :make<CR>
nnoremap <Leader>fl :source %<CR>

nnoremap <Leader><Leader> :Buffers<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>bd :bprevious<CR>:bdelete #<CR>
nnoremap <Leader>bk :bprevious<CR>:bdelete! #<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>

nnoremap <Leader>tc :tabnew<CR>
nnoremap <Leader>tn :tabnext<CR>
nnoremap <Leader>tp :tabprevious<CR>

nnoremap <Leader>sa :Ag<CR>
nnoremap <Leader>sw :Ag <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>sf :Files<CR>
" nnoremap <Leader>sg :GFiles?<CR>
nnoremap <Leader>sm :Marks<CR>
nnoremap <Leader>sc :Commits<CR>

augroup pyadds
  au!
  autocmd FileType python iabbrev <buffer> ppr from pprint import pprint<CR>pprint()<Left>
  autocmd FileType python iabbrev <buffer> ppdb import pdb; pdb.set_trace()
  " autocmd FileType python nnoremap <buffer> <Leader>sg :call jedi#goto()<CR>
  " autocmd FileType python nnoremap <buffer> <Leader>su :call jedi#usages()<CR>
  " autocmd FileType python nnoremap <buffer> <Leader>sr :call jedi#rename()<CR>
  " autocmd FileType python vnoremap <buffer> <Leader>sr :call jedi#rename_visual()<CR>
augroup END

augroup jsadds
  au!
  autocmd FileType javascript iabbrev <buffer> cl console.log()<Left>
augroup END

nnoremap <Leader>ls :mksession! .session.vim<CR>
nnoremap <Leader>ll :source .session.vim<CR>

nnoremap <Leader>cc :copen<CR>
nnoremap <Leader>cq :cclose<CR>
nnoremap <Leader>cj :cnext<CR>
nnoremap <Leader>ck :cprev<CR>

nnoremap <Leader>tw0 :set nowrap<CR>
nnoremap <Leader>tw1 :set wrap<CR>

nnoremap <Leader>ar :RangerEdit<CR>
nnoremap <Leader>as :Deol<CR>
nnoremap <Leader>ag :Magit<CR>




"
"
"
"
"
"

" highlight clear ALEErrorSign
" highlight clear ALEWarningSign

if $TERM=~'linux'
    syntax enable
    set t_Co=16
    colorscheme gotham
else
    syntax enable
    set t_Co=256
    set background=light
    colorscheme cobalt2
    highlight SpecialKey ctermbg=none cterm=none ctermfg=DarkGray
    highlight NonText ctermbg=none cterm=none ctermfg=DarkGray
    highlight ColorColumn ctermbg=235 guibg=#FFC600
    highlight Conceal cterm=NONE ctermbg=NONE ctermfg=LightGray
endif
