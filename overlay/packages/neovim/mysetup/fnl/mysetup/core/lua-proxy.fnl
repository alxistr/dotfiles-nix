(when (= nil (. _G :lua_proxy))
  (global lua_proxy {:counter 0
                     :mapping {}
                     :funcs {}}))

(fn get-id []
  (let [id lua_proxy.counter]
    (tset lua_proxy :counter (+ id 1))
    id))

(fn get-mapped [f]
  (let [dumped (string.dump f)
        id (. lua_proxy.mapping dumped)]
    (if (not= nil id)
      id
      (let [id (get-id)]
        (tset lua_proxy.mapping dumped id)
        (tset lua_proxy.funcs id f)
        id))))

(fn register-function [f]
  (let [id (get-mapped f)]
    (.. "lua_proxy.funcs[" id "]")))

{: register-function}
