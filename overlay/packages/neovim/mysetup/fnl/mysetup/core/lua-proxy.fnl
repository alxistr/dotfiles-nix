(local register {:counter 0
                 :mapping {}
                 :funcs {}})

(local module "require('mysetup.core.lua-proxy')")

(fn get-id []
  (let [id register.counter]
    (tset register :counter (+ id 1))
    id))

(fn get-mapped [f]
  (let [dumped (string.dump f)
        id (. register.mapping dumped)]
    (if (not= nil id)
      id
      (let [id (get-id)]
        (tset register.mapping dumped id)
        (tset register.funcs id f)
        id))))

(fn create-proxy [f]
  (let [id (get-mapped f)]
    (..  module ".register.funcs[" id "]")))

{: register : create-proxy}
