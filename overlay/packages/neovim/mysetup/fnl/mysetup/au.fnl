(require-macros :mysetup.vim-macro)

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
