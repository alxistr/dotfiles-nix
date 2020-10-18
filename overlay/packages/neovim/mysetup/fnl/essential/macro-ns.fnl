(require-macros :essential.macro-core)

(local module (sym "*ns*"))

(fn import [path binds]
  (if-not binds
    `(require ,path)
    `(->> (require ,path)
          (local ,binds))))

(fn in-ns [name]
  `(set ,module (require ,name)))

(fn unpack-ns-rest [r]
  (let [t []]
    (each [_ [k & v] (pairs r)]
      (tpush t `(,(sym (tostring k))
                  ,(unpack v))))
    t))

(fn ns [name ...]
  `[(var ,module
      (let [name# ,(tostring name)
            loaded# (. package.loaded name#)
            module# (if (= :table (type loaded#))
                      loaded#
                      {})]
        (->> (or (. module# :ns/locals)
                 {})
             (tset module# :ns/locals))
        (tset package.loaded name# module#)
        module#))
    ,(unpack-ns-rest [...])])


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

(fn to-symbols [t]
  (let [t* []]
    (each [name (pairs t)]
      (tpush t* (sym name)))
    t*))

(fn with-do [t]
  (let [t* (list)]
    (tpush t* (sym "do"))
    (each [_ v (pairs t)]
      (tpush t* v))
    t*))

(fn build-match-clauses [t]
  (let [t* []]
    (each [_ [a & b] (pairs t)]
      (assert (= :table (type a)))
      (tpush t* a)
      (tpush t* (with-do b)))
    t*))

(fn unpack-fn [name r]
  (if-not (list? (. r 1))
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
