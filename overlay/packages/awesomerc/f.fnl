(let [inspect (require :inspect)
      moses (require :moses)
      binding (fn [f]
                (fn [...]
                  ;(print (inspect (moses.map [...]
                  ;                           (fn [value]
                  ;                             (f value))]
                  (moses.map [...]
                             (fn [value]
                               (print (inspect {:who "value"
                                                :value value}))
                               ;value
                               (f value)))))

      f (fn [...]
          (print (inspect {:who "f"
                           :vararg ...}))
          ...)

      binder (binding f)]

  (binder
    [[] 1 (fn [] 1)]
    [[] 3 (fn [] 2)]
    [[] 4 (fn [] 3)]
    [[] 5 (fn [] 4)]))

