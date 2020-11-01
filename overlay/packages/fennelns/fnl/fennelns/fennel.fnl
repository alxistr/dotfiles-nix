(local fennel (require :fennel))
(->> (require :fennelns.patch)
     (local {: patch-source}))

(local m {})

(fn m.dofile [filename opts ...]
  (let [opts (or opts {})
        f (io.open filename :rb)
        source (-> (f:read :*all)
                   (assert (.. "Could not read " filename)))]
    (f:close)
    (set opts.filename filename)
    (fennel.eval (patch-source source)
                 opts ...)))

m
