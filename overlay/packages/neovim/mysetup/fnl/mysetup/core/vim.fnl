(->> (require :mysetup.core.lua-proxy)
     (local {: register-function}))
(->> (require :mysetup.core.fun)
     (local {: partition
             : tuples
             : tuples->table
             : map
             : defaults
             : tpop
             : nil?}))

(fn set-attrs [m ...]
  (if (= 1 (length [...]))
   (each [name value (pairs ...)]
     (tset m name value))
   (->> [...]
        (partition 2)
        (tuples->table)
        (set-attrs m))))

(fn fmt! [f ...]
  (string.format f ...))

(fn vim! [cmd]
  (vim.api.nvim_command cmd))

(fn au [opts]
  (let [event (or (. opts :event)
                  "*")
        pattern (or (. opts :pattern)
                    "*")
        cmd (. opts :cmd)
        cmd (if (not= "function" (type cmd))
              cmd
              (->> (register-function cmd)
                   (fmt! "lua %s()")))]
    (pp cmd)
    (fmt! "au %s %s %s" event pattern cmd)))

(fn g! [...] (set-attrs vim.g ...))
(fn o! [...] (set-attrs vim.o ...))
(fn bo! [...] (set-attrs vim.bo ...))
(fn wo! [...] (set-attrs vim.wo ...))

;(fn leader-map!)
;(fn local-map!)

(fn bindings-modifier [f bindings]
  (->> bindings
      (tuples)
      (map (fn [[key value]]
             (f key value)))
      (tuples->table)))


(fn map! [...])

(comment (fn map! [bindings ...]
           (assert (= (% (length [...]) 2)
                      0))
           (let [options (->> [...]
                              (partition 2)
                              (tuples->table)
                              (defaults {:mode "n"
                                         :noremap? true
                                         :leader? false
                                         :local-leader? false
                                         :buffer? nil
                                         :silent? false
                                         :expr? false}))
                 {: mode
                  : noremap?
                  : leader?
                  : local-leader?
                  : buffer?
                  : silent?
                  : expr?} options
                 keymap-opts {:noremap noremap?
                              :silent silent?
                              :expr expr?}]
             ;f (if (nil? buffer?)
             ;    vim.api.nvim_set_keymap
             ;    vim.api.nvim_buf_set_keymap]
             (assert (or (not leader?)
                         (not= leader? local-leader?)))
             (fmt! "%s%smap %s %s %s"
                   mode
                   (if noremap? "nore" "")
                   "")
             ;lhs rhs)
             ;(f mode lhs rhs keymap-opts)
             (pp {:opts keymap-opts}))))

;(each [lhs rhs (pairs bindings)]
;  (f mode lhs rhs keymap-opts)))

{: fmt!
 : au
 : vim!
 : g!
 : o!
 : bo!
 : wo!
 : map!}
