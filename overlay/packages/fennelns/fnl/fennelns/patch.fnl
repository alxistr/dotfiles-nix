(local fennel (require :fennel))

(var macros-list [:fennelns.macro-core
                  :fennelns.macro-ns])

(fn get-head []
  (var result "")
  (each [_ l (pairs macros-list)]
    (->> (.. "(require-macros \"" l "\")")
         (.. result)
         (set result)))
  result)

(fn wrapper [f]
  (fn [str opts]
    (-> (.. (get-head)
            str
            "(tail-ns)")
        (f opts))))

(fn patch [f k]
  (->> (-> (. fennel k)
           (f))
       (tset fennel k)))

(fn patch-fennel [fennel]
  (when (not (. fennel :patched))
    (patch wrapper :eval)
    (patch wrapper :compile-string)
    (tset fennel :patched true)
    fennel))

(fn add-macros [name]
  (table.insert macros-list name))

(patch-fennel fennel)

{: add-macros}
