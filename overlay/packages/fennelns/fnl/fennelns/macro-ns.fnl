(require-macros :fennelns.macro-core)

(local module (sym "*ns*"))

(fn import [path binds]
  (if-not binds
    `(require ,path)
    `(->> ,(if (sym? path)
             path
             `(require ,path))
          (local ,binds))))

(fn in-ns [name]
  `(set ,module (require ,name)))

(fn ns [name ...]
  `(-> [(var ,module
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

        ,module

        ,(let [t []]
           (each [_ [k n b] (pairs [...])]
             (->> `(,(sym (tostring k)) ,n ,b)
                  (table.insert t))
             (if (and (sym? n)
                      b (table? b))
               (each [_ v (pairs b)]
                 (->> `(tset ,module ,(tostring v) ,v)
                      (table.insert t)))))
           t)]

       (. 2)))

(fn def- [name value]
  `(-> [(local ,name
          (let [value# ,value
                locals# (. ,module :ns/locals)]
            (tset locals# ,(tostring name) value#)
            value#))
        ,module]
       (. 2)))

(fn def [name value]
  `(-> [(local ,name
          (let [value# ,value]
            (tset ,module ,(tostring name) value#)
            value#))
        ,module]
       (. 2)))

(fn defonce- [name value]
  `(def- ,name (or (. (. ,module :ns/locals)
                      ,(tostring name))
                   ,value)))

(fn defonce [name value]
  `(def ,name (or (. ,module ,(tostring name))
                  ,value)))

(fn defn- [name ...]
  `(def- ,name (fn ,name ,...)))

(fn defn [name ...]
  `(def ,name (fn ,name ,...)))

{: import
 : ns : in-ns
 : def : def-
 : defonce : defonce-
 : defn : defn-}
