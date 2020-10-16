(->> (require :mysetup.core.fun)
     (local {: seq->table
             : map-kv
             : extends}))
(->> (require :mysetup.core.vim.runtime)
     (local {: proxy-if-function
             : vim!
             : fmt!}))
(local {:nvim_set_keymap set-keymap
        :nvim_buf_set_keymap set-buf-keymap}
       vim.api)

(fn extend-bindings [bindings leader? local?]
  (let [prefix (if
                 leader? "<leader>"
                 local? "<localleader>"
                 "")]
    (map-kv (fn [[lhs rhs]]
              [(.. prefix lhs) rhs])
            bindings)))

(fn collect-opts [...]
  (->> (seq->table [...])
       (extends {:noremap? true
                 :leader? false
                 :local? false
                 :buffer? false
                 :silent? false
                 :expr? false})))

(fn bind [mode lhs rhs buffer? keymap-opts]
  (let [rhs (->> {:prefix ":lua" :suffix "<CR>"}
                 (proxy-if-function rhs))
        [buffer? buffer] (match buffer?
                           false [false nil]
                           true [true 0]
                           [true buffer?])]
    (if buffer?
      (set-buf-keymap buffer mode lhs rhs keymap-opts)
      (set-keymap mode lhs rhs keymap-opts))))

(fn create-mapper [mode]
  (fn [bindings ...]
    (let [{: leader? : local? : buffer?
           : noremap? : silent? : expr?} (collect-opts ...)]
      (each [lhs rhs (-> bindings
                         (extend-bindings leader? local?)
                         (pairs bindings))]
        (bind mode lhs rhs buffer? {:noremap noremap?
                                    :silent silent?
                                    :expr expr?})))))

(->> {:map! ""
      :icmap! "!"
      :nmap! "n"
      :vmap! "v"
      :smap! "s"
      :xmap! "x"
      :omap! "o"
      :imap! "i"
      :lmap! "l"
      :cmap! "c"
      :tmap! "t"}
     (map-kv (fn [[name mode]]
               [name (create-mapper mode)])))
