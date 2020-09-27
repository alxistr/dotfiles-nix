(local {: partition : tuples->table} (require :mysetup.core.fun))

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

(fn g! [...]
  (if (= 1 (length [...]))
    (each [name value (pairs ...)]
      (vim.api.nvim_set_var name value))
    (->> [...]
         (partition 2)
         (tuples->table)
         (g!))))

(fn o! [...]
  (if (= 1 (length [...]))
    (each [name value (pairs ...)]
      (vim.api.nvim_set_option name value))
    (->> [...]
         (partition 2)
         (tuples->table)
         (g!))))

{: fmt!
 : au
 : vim!
 : g!
 : o!}
