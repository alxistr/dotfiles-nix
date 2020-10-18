(ns :mysetup.core.vim.attrs
    (:import :mysetup.core.fun
             {: partition
              : seq->table})
    (:import :mysetup.core.vim.runtime
             {: join-if-table}))

(defn set-attrs [m ...]
  (if (= 1 (length [...]))
   (each [name value (pairs ...)]
     (let [value (join-if-table value)]
       (tset m name value)))
   (->> (seq->table [...])
        (set-attrs m))))

(defn g! [...] (set-attrs vim.g ...))
(defn o! [...] (set-attrs vim.o ...))
(defn bo! [...] (set-attrs vim.bo ...))
(defn wo! [...] (set-attrs vim.wo ...))
