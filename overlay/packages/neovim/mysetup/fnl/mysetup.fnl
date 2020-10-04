(require-macros :mysetup.core.macro)
(require :mysetup.core.fennel)
(->> (require :mysetup.core.vim)
     (local {: au : fmt! : vim! : map!
             : g! : o! : wo!}))

(do
  (augroup "testshit"
    (comment (-> (au {:event "CursorMoved"
                      :cmd (fn []
                             (->> (vim.call "expand" "<cWORD>")
                                  (fmt! "echo \"%s\"")
                                  (vim.cmd)))})
                (vim!))))

  nil)

; options

(do
  (-> {:autoread true
       :tabstop 4
       :shiftwidth 4
       :mouse "a"
       :expandtab true
       :incsearch true
       :tags "tags"
       :completeopt (-> ["menuone"
                         "noinsert"
                         "noselect"]
                        (table.concat ","))
       :clipboard "unnamedplus"
       :shortmess "filnxtToOFc"
       :viminfo "'500"}
      (o!))

  (-> {:nu true
       :list true
       :cursorline true
       :cursorcolumn false
       :colorcolumn "80"
       :wrap false
       :foldmethod "indent"
       :foldenable false}
      (wo!))

  (-> {:showbreak "↪\\"
       :listchars (-> ["tab:→\\ "
                       "eol:↲"
                       "nbsp:·"
                       "space:·"
                       "trail:␠"
                       "extends:⟩"
                       "precedes:⟨"]
                      (table.concat ","))}
      (o!))

  (-> {:langmap (-> ["ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                     "фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"]
                    (table.concat ","))}
      (o!)))

; misc

(do
  (augroup "misc"
    (-> (au {:event "CursorHold"
             :cmd "checktime"})
        (vim!)))

  (augroup "helpfiles"
    (each [_ event (pairs ["BufRead"
                           "BufEnter"])]
      (-> (au {: event
               :pattern "*/doc/*"
               :cmd "wincmd L"})
          (vim!))))

  (augroup "trimfiles"
    (each [_ filetype (pairs ["python"
                              "javascript"
                              "fennel"
                              "go"
                              "conf"
                              "vim"
                              "lua"
                              "erlang"
                              "clojure"
                              "nix"])]
      (-> (au {:event "FileType"
               :pattern filetype
               :cmd (au {:event "BufWritePre"
                         :cmd "%s/\\s\\+$//e"})})
          (vim!)))))

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
    (each [_ filetype (pairs ["clojure"
                              "racket"
                              "lisp"
                              "scheme"
                              "hy"
                              "fennel"])]
      (-> (au {:event "FileType"
               :pattern filetype
               :cmd "ParinferOn"})
          (vim!)))))

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

       :<Leader> ":Buffers<CR>"
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

       ;:ttd ":set background=dark<CR>"
       ;:ttl ":set background=light<CR>"
       :tl ":set wrap!<CR>"

       :ls ":mksession! .session.vim<CR>"
       :ll ":source .session.vim<CR>"}

      (map! :leader? true)))
