(->> (.. "(require-macros :fennelns.macro-core)"
         "(require-macros :fennelns.macro-ns)")
     (local head))

(fn with-prelude* [f]
  (fn [str opts ...]
    (-> (.. head str)
        (f opts ...))))

(fn patch-fennel [fennel]
  (when (not (. fennel :patched))
    (let [patch (fn [f k r]
                  (->> (-> (. fennel (or r k))
                           (f))
                       (tset fennel k)))]
      (patch with-prelude* :eval)
      (patch with-prelude* :compile-string)
      (tset fennel :patched true)
      fennel)))

(let [fennel (require :fennel)]
  (patch-fennel fennel))
