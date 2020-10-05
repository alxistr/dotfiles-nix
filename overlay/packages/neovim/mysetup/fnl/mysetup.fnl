(require :mysetup.core.fennel)
(->> (require :mysetup.core.vim)
     (local {: augroup : au
             : fmt! : vim!
             : g! : o! : wo! : bo!
             : nmap! : icmap!}))

; options

(do
  (-> {:autoread true
       :tabstop 4
       :shiftwidth 4
       :mouse "a"
       :expandtab true
       :incsearch true
       :tags "tags"
       :completeopt ["menuone"
                     "noinsert"
                     "noselect"]
       :clipboard "unnamedplus"
       :shortmess "filnxtToOFc"
       :viminfo "'500"
       :showbreak "↪\\"
       :listchars ["tab:→\\ "
                   "eol:↲"
                   "nbsp:·"
                   "space:·"
                   "trail:␠"
                   "extends:⟩"
                   "precedes:⟨"]
       :langmap ["ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                 "фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"]}
      (o!))

  (-> {:nu true
       :list true
       :cursorline true
       :cursorcolumn false
       :colorcolumn "80"
       :wrap false
       :foldmethod "indent"
       :foldenable false}
      (wo!)))

; misc

(do
  (augroup "misc"
           {:event "CursorHold"
            :cmd "checktime"})

  (augroup "helpfiles"
           {:event ["BufRead" "BufEnter"]
            :pattern "*/doc/*"
            :cmd "wincmd L"})

  (augroup "trimfiles"
           {:event "FileType"
            :pattern ["python"
                      "javascript"
                      "fennel"
                      "go"
                      "conf"
                      "vim"
                      "lua"
                      "erlang"
                      "clojure"
                      "nix"]
            :cmd (au {:event "BufWritePre"
                      :cmd "%s/\\s\\+$//e"})}))

; magit

(do
  (-> {:magit_default_show_all_files 0
       :magit_default_fold_level 0}
      (g!)))

; parinfer

(do
  (-> {:parinfer_mode "smart"
       :parinfer_force_balance 1}
      (g!))

  (augroup "parinfer"
           {:event "FileType"
            :pattern ["clojure"
                      "racket"
                      "lisp"
                      "scheme"
                      "hy"
                      "fennel"]
            :cmd "ParinferOn"}))

; magit

(do
  (-> {:magit_default_show_all_files 0
       :magit_default_fold_level 0}
      (g!)))

; bindings

(do
  (-> {:mapleader " "
       :maplocalleader "\\"}
      (g!))

  (-> {:fs ":w<CR>"

       :<leader> ":Buffers<CR>"
       :bb ":Buffers<CR>"
       :bd ":bprevious<CR>:bdelete #<CR>"
       :bk ":bprevious<CR>:bdelete! #<CR>"
       :bj ":bnext<CR>"
       :bk ":bprevious<CR>"

       :tc ":tabnew<CR>"
       :tj ":tabnext<CR>"
       :tk ":tabprevious<CR>"

       :cc ":copen<CR>"
       :cq ":cclose<CR>"
       :cj ":cnext<CR>"
       :ck ":cprev<CR>"

       :sa ":Ag<CR>"
       :sw ":Ag <C-R>=expand(\"<cword>\")<CR><CR>"
       :sf ":Files<CR>"
       :sr ":History<CR>"
       :sm ":Marks<CR>"
       :sc ":Commits<CR>"

       :ar ":RangerEdit<CR>"
       :as ":Deol<CR>"
       :ag ":Magit<CR>"

       :ga ":Git add %:p<CR><CR>"
       :gs ":Gstatus<CR><C-w>L"
       :gc ":Gcommit<CR><C-w>L"
       :gi ":Git rebase -i<CR>"
       :gbl ":Gblame<CR>"

       :tl ":set wrap!<CR>"

       :ls ":mksession! .session.vim<CR>"
       :ll ":source .session.vim<CR>"}

      (nmap! :leader? true))

  (-> {:<C-l> ":noh<CR><C-l>"}
      (nmap! :silent? true))

  (-> {:<M-j> "<Down>"
       :<M-k> "<Up>"
       :<M-h> "<Left>"
       :<M-l> "<Right>"}
      (icmap!))

  nil)
