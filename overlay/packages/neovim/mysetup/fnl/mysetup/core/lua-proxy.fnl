(if (= nil (. _G :lua_proxy))
  (global lua_proxy {:counter 0}))

(fn get-id []
  (let [id lua_proxy.counter]
    (tset lua_proxy :counter (+ id 1))
    id))

(fn register-function [f]
  (let [id (.. "lua_proxy_f__" (get-id))]
    (tset _G id f)
    id))

{: get-id
 : register-function}
