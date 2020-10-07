(->> (require :mysetup.core.fun)
     (local {: map : reduce : tuples}))

(comment
  "<cword>"
  "<cWORD>"
  "<cexpr>"
  "<cfile>"
  "<afile>"
  "<abuf>"
  "<amatch>"
  "<sfile>"
  "<slnum>"
  "<sflnum>"
  nil)

(comment
  (augroup "readonly-fennel"
           {:event "FileType"
            :pattern "fennel"
            :cmd (fn []
                   (bo! :modifiable false))}))


(comment
  (augroup "testshit"
           {:event "CursorMoved"
            :cmd (fn []
                   (->> (vim.call "expand" "<cWORD>")
                        (fmt! "echo \"%s\"")
                        (vim.cmd))
                   nil)}))


(comment
  (-> (fn [id]
        (let [lines-count (vim.api.nvim_buf_line_count id)]
          (pp [id lines-count (vim.api.nvim_buf_get_name id)])))
     (map (vim.api.nvim_list_bufs))))

; ---

(comment
  (do
    (aug "confc"
         {:event "CursorMoved"
          :cmd (fn []
                 (vim.cmd (fmt! "echo %s" (math.random))))})

    (g! :mapleader " ")
    (-> {:lj (fn []
               (pp "OK"))}
        (nmap! :leader? true :silent? true))

    nil))

; todo

; command! -nargs=1 Fnl :lua fnleval(<f-args>)
; command! -nargs=? -complete=file FnlFile :Fnl (fnlfile <f-args>)
