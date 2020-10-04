(->> (require :mysetup.core.fun)
     (local {: partition : tuples->table}))

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
  (let [opts opts
        event (or (. opts :event)
                  "*")
        pattern (or (. opts :pattern)
                    "*")
        cmd (. opts :cmd)]
    (fmt! "au %s %s %s" event pattern cmd)))

(fn g! [...] (set-attrs vim.g ...))
(fn o! [...] (set-attrs vim.o ...))
(fn bo! [...] (set-attrs vim.bo ...))
(fn wo! [...] (set-attrs vim.wo ...))

{: fmt!
 : au
 : vim!
 : g!
 : o!
 : bo!
 : wo!}
