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
set clipboard+=unnamedplus
set nowrap
set completeopt-=preview
set autoread
set viminfo='500

au CursorHold * checktime

noremap <silent> <C-l> :noh<CR><C-l>
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-h> <Left>
imap <M-l> <Right>

let mapleader = " "
let maplocalleader = "\\"

nnoremap <Leader>fs :w<CR>

nnoremap <Leader><Leader> :Buffers<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>bd :bprevious<CR>:bdelete #<CR>
nnoremap <Leader>bk :bprevious<CR>:bdelete! #<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>

nnoremap <Leader>sa :Ag<CR>
nnoremap <Leader>sw :Ag <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>sf :Files<CR>
nnoremap <Leader>sr :History<CR>
nnoremap <Leader>sm :Marks<CR>
nnoremap <Leader>sc :Commits<CR>

nnoremap <Leader>ar :RangerEdit<CR>
nnoremap <Leader>as :Deol<CR>
nnoremap <Leader>ag :Magit<CR>

nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR><C-w>L
nnoremap <Leader>gc :Gcommit<CR><C-w>L
nnoremap <Leader>gi :Git rebase -i<CR>
nnoremap <Leader>gbl :Gblame<CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END

augroup trimfiles
  au!
  au FileType python,javascript,go,conf,vim,lua,erlang,clojure,nix au BufWritePre * %s/\s\+$//e
augroup END

let g:airline_theme='gruvbox'

let g:parinfer_mode = 'smart'
let g:parinfer_force_balance = 1

augroup parinfer-autoenable
  au!
  au FileType clojure,racket,lisp,scheme,hy,fennel ParinferOn
augroup END

let g:magit_default_show_all_files = 0
let g:magit_default_fold_level = 0

function! s:build_quickfix_list(lines)
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

if $TERM=~'linux'
    set t_Co=16
    colorscheme gotham
else
    set t_Co=256
    set background=dark
    colorscheme gruvbox
    highlight SpecialKey ctermbg=none cterm=none ctermfg=DarkGray
    highlight NonText ctermbg=none cterm=none ctermfg=DarkGray
    highlight ColorColumn ctermbg=235 guibg=#FFC600
    highlight Conceal cterm=NONE ctermbg=NONE ctermfg=LightGray
endif

luado require('mysetup')
