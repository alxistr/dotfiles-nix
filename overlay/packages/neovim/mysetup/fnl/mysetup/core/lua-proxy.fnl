(ns :mysetup.core.lua-proxy)

(defonce cache {:counter 0
                :funcs {}})

(defn get-id []
  (let [id cache.counter]
    (tset cache :counter (+ id 1))
    id))

(defn get-mapped [f]
  (let [id (get-id)]
    (tset cache.funcs id f)
    id))

(defn create-proxy [f]
  (let [id (get-mapped f)]
    (.. "require(\""
        :mysetup.core.lua-proxy
        "\").cache.funcs["
        id
        "]")))
