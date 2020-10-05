(if (= nil (. _G :lua_proxy))
  (global lua_proxy {:counter 0
                     :funcs {}}))

(fn get-id []
  (let [id lua_proxy.counter]
    (tset lua_proxy :counter (+ id 1))
    id))

(fn register-function [f]
  (let [id (get-id)]
    (tset lua_proxy.funcs id f)
    (.. "lua_proxy.funcs[" id "]")))

{: get-id
 : register-function}
