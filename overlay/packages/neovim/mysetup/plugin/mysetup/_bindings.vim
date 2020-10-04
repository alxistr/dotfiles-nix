let mapleader = " "
let maplocalleader = "\\"


nnoremap <Leader>fs :w<CR>

nnoremap <Leader><Leader> :Buffers<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>bd :bprevious<CR>:bdelete #<CR>
nnoremap <Leader>bk :bprevious<CR>:bdelete! #<CR>
nnoremap <Leader>bj :bnext<CR>
nnoremap <Leader>bk :bprevious<CR>

nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tj :tabnext<CR>
nnoremap <Leader>tk :tabprevious<CR>

nnoremap <Leader>cc :copen<CR>
nnoremap <Leader>cq :cclose<CR>
nnoremap <Leader>cj :cnext<CR>
nnoremap <Leader>ck :cprev<CR>

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

cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-h> <Left>
cnoremap <M-l> <Right>


" let i = 1
" while i <= 9
"     execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
"     let i = i + 1
" endwhile


" nnoremap <silent> <M-h> zC
" nnoremap <silent> <M-s> zO
" nnoremap <silent> <C-M-h> zM
" nnoremap <silent> <C-M-s> zR
