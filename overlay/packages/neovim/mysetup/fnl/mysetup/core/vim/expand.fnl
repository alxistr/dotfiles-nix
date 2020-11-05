(ns :mysetup.core.vim.expand
    (:import :mysetup.core.fun
             {: map : tuples->table}))

(each [_ name (pairs [:cword
                      :cWORD
                      :cexpr
                      :cfile
                      :afile
                      :abuf
                      :amatch
                      :sfile
                      :slnum
                      :sflnum])]
  (let [ename (.. "<" name ">")]
    (->> #(vim.fn.expand ename)
         (tset *ns* name))))
