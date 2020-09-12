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

nnoremap <Leader>ttd :set background=dark<CR>
nnoremap <Leader>ttl :set background=light<CR>
nnoremap <Leader>tl :set wrap!<CR>

nnoremap <Leader>ls :mksession! .session.vim<CR>
nnoremap <Leader>ll :source .session.vim<CR>


noremap <silent> <C-l> :noh<CR><C-l>
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-h> <Left>
imap <M-l> <Right>
