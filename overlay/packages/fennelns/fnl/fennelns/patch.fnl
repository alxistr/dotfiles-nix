(local fennel (require :fennel))

(var macros-list [:fennelns.macro-core
                  :fennelns.macro-ns])

(fn get-head []
  (var result "")
  (each [_ l (pairs macros-list)]
    (->> (.. "(require-macros \"" l "\")")
         (.. result)
         (set result)))
  (.. result
      "(head-ns)"))

(fn patch-source [str]
  (.. (get-head)
      str
      "(tail-ns)"))

(fn wrapper [f]
  (fn [str opts ...]
    (-> (patch-source str)
        (f opts ...))))

(fn patch [f k]
  (->> (-> (. fennel k)
           (f))
       (tset fennel k)))

(fn static-patch []
  (patch wrapper :compile-string))

(fn add-macros [name]
  (table.insert macros-list name))

{: get-head
 : patch-source
 : add-macros
 : static-patch}
