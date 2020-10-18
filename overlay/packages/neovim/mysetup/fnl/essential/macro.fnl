(local module (sym "*ns*"))

(fn import [path binds]
  (if (not binds)
    `(require ,path)
    `(->> (require ,path)
          (local ,binds))))

(fn in-ns [name]
  `(set ,module (require ,name)))

(fn ns [name]
  `[(var ,module
      (let [name# ,(tostring name)
            loaded# (. package.loaded name#)
            module# (if (= :table (type loaded#))
                      loaded#
                      {})]
        (tset module# :ns/locals (or (. module# :ns/locals)
                                     {}))
        (tset package.loaded name# module#)
        module#))])

(fn unpack-rest [m ...]
  (let [r [...]]
    (when (< 0 (length r))
      (m (unpack r)))))

(fn def- [name value ...]
  `[(local ,name
      (let [name# ,(tostring name)
            value# ,value
            locals# (. ,module :ns/locals)]
        (tset locals# name# value#)
        value#))
    ,(unpack-rest def- ...)])

(fn def [name value ...]
  `[(local ,name
      (let [name# ,(tostring name)
            value# ,value]
        (tset ,module name# value#)
        value#))
    ,(unpack-rest def ...)])

(fn defonce- [name value ...]
  `[(def- ,name (or (. (. ,module :ns/locals)
                       ,(tostring name))
                    ,value))
    ,(unpack-rest defonce- ...)])

(fn defonce [name value ...]
  `[(def ,name (or (. ,module ,(tostring name))
                   ,value))
    ,(unpack-rest defonce ...)])

(fn append [t val]
  (tset t (+ 1 (length t)) val))

(fn to-symbols [t]
  (let [t* []]
    (each [name (pairs t)]
      (append t* (sym name)))
    t*))

(fn with-do [t]
  (let [t* (list)]
    (append t* (sym "do"))
    (each [_ v (pairs t)]
      (append t* v))
    t*))

(fn build-match-clauses [t]
  (let [t* []]
    (each [_ [a & b] (pairs t)]
      (assert (= :table (type a)))
      (append t* a)
      (append t* (with-do b)))
    t*))

(fn unpack-fn [name r]
  (if (not (list? (. r 1)))
    `(fn ,name ,(unpack r))
    `(fn ,name [...]
       (let [args# [...]]
         (match args#
           ,(-> (build-match-clauses r)
                (unpack)))))))

(fn defn- [name ...]
  `(def- ,name ,(unpack-fn name [...])))

(fn defn [name ...]
  `(def ,name ,(unpack-fn name [...])))

{: import
 : ns : in-ns
 : def : def-
 : defonce : defonce-
 : defn : defn-}
