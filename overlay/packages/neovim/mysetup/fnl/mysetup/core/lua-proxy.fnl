(when (= nil (. _G :lua_proxy))
  (global lua_proxy {:counter 0
                     :mapping {}
                     :funcs {}}))

(fn get-id []
  (let [id lua_proxy.counter]
    (tset lua_proxy :counter (+ id 1))
    id))

(fn dump-function [f]
  (let [b (string.dump f)
        r {:v ""}]
    (for [i 1 (length b)]
      (let [byte (string.byte b i)
            c (if (and (>= byte 32)
                       (<= byte 126))
                (string.char byte)
                (string.format "-%02x-" byte))]
        (tset r :v (.. r.v c))))
    r.v))

(fn get-mapped [f]
  (let [dumped (dump-function f)
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
