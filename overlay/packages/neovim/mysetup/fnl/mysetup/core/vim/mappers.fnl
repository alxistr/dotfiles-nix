(->> (require :mysetup.core.fun)
     (local {: partition
             : tuples
             : tuples->table
             : reduce
             : map
             : extends}))
(->> (require :mysetup.core.vim.runtime)
     (local {: join-if-table
             : register-if-function
             : vim!
             : fmt!}))
(->> vim.api
     (local {:nvim_set_keymap set-keymap
             :nvim_buf_set_keymap set-buf-keymap}))

(fn extend-bindings [bindings leader? local-leader?]
  (let [prefix (if
                 leader? "<leader>"
                 local-leader? "<localleader>"
                 "")]
    (->> bindings
         (tuples)
         (map (fn [[lhs rhs]]
                [(.. prefix lhs) rhs]))
         (tuples->table))))

(fn create-mapper [mode]
  (fn [bindings ...]
    (let [options (->> [...]
                       (partition 2)
                       (tuples->table)
                       (extends {:noremap? true
                                 :leader? false
                                 :local-leader? false
                                 :buffer? false
                                 :silent? false
                                 :expr? false}))
          {: noremap?
           : leader?
           : local-leader?
           : buffer?
           : silent?
           : expr?} options
          keymap-opts {:noremap noremap?
                       :silent silent?
                       :expr expr?}]
      (each [lhs rhs (-> bindings
                         (extend-bindings leader? local-leader?)
                         (pairs bindings))]
        (if (= buffer? false)
          (set-keymap mode lhs rhs keymap-opts)
          (set-buf-keymap buffer? mode lhs rhs keymap-opts))))))

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
     (tuples)
     (reduce (fn [memo [name mode]]
               (->> (create-mapper mode)
                    (tset memo name))
               memo)
             {}))
