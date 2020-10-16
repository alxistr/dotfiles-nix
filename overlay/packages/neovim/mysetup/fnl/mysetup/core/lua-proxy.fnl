(local module-name :mysetup.core.lua-proxy-cache)

(fn get-id []
  (let [cache (require module-name)
        id cache.counter]
    (tset cache :counter (+ id 1))
    id))

(fn get-all-upvalues [f]
  (var continue? true)
  (var index 0)
  (var upvalues [])
  (while continue?
    (set index (+ 1 index))
    (let [[name value] [(debug.getupvalue f index)]]
      (when name
        (tset upvalues name value))
      (set continue? name)))
  upvalues)

(fn get-func-hash [f]
  (.. (string.dump f)
      (vim.inspect (get-all-upvalues f))))

(fn get-mapped [f]
  (let [cache (require module-name)
        h (get-func-hash f)
        id (. cache.mapping h)]
    (if (not= nil id)
      id
      (let [id (get-id)]
        (tset cache.mapping h id)
        (tset cache.funcs id f)
        id))))

(fn create-proxy [f]
  (let [id (get-mapped f)]
    (.. "require(\"" module-name "\").funcs[" id "]")))

{: create-proxy}
