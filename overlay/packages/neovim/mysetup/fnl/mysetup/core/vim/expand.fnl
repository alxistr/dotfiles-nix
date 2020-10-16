(->> (require :mysetup.core.fun)
     (local {: map : tuples->table}))

(->> [:cword
      :cWORD
      :cexpr
      :cfile
      :afile
      :abuf
      :amatch
      :sfile
      :slnum
      :sflnum]
     (map (fn [name]
            (let [ename (.. "<" name ">")]
              [name #(vim.fn.expand ename)])))
     (tuples->table))
