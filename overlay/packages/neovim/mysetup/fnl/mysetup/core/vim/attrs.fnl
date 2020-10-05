(->> (require :mysetup.core.fun)
     (local {: partition
             : tuples->table}))
(->> (require :mysetup.core.vim.runtime)
     (local {: join-if-table}))

(fn set-attrs [m ...]
  (if (= 1 (length [...]))
   (each [name value (pairs ...)]
     (let [value (join-if-table value)]
       (tset m name value)))
   (->> [...]
        (partition 2)
        (tuples->table)
        (set-attrs m))))

(fn g! [...] (set-attrs vim.g ...))
(fn o! [...] (set-attrs vim.o ...))
(fn bo! [...] (set-attrs vim.bo ...))
(fn wo! [...] (set-attrs vim.wo ...))

{: g! : o! : bo! : wo!}
