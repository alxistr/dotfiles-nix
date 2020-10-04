(require-macros :mysetup.core.macro)
(require :mysetup.core.fennel)
(->> (require :mysetup.core.vim)
     (local {: au : fmt! : vim!
             : g! : o! : wo!}))

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
