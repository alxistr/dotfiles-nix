(local module-name :mysetup.core.lua-proxy-cache)

(fn get-id []
  (let [cache (require module-name)
        id cache.counter]
    (tset cache :counter (+ id 1))
    id))

(fn get-mapped [f]
  (let [cache (require module-name)
        id (get-id)]
    (tset cache.funcs id f)
    id))

(fn create-proxy [f]
  (let [id (get-mapped f)]
    (.. "require(\"" module-name "\").funcs[" id "]")))

{: create-proxy}
