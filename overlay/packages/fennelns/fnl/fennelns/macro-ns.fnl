(require-macros :fennelns.macro-core)

(var ns-defined false)
(local module (sym "*ns*"))

(fn import [path binds]
  (if-not binds
    `(require ,path)
    `(->> ,(if (sym? path)
             path
             `(require ,path))
          (local ,binds))))

(fn tail-ns []
  (assert ns-defined "namespace isn't defined")
  module)

(fn in-ns [name]
  `(set ,module (require ,name)))

(fn ns [name ...]
  (set ns-defined true)
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

    ,(let [t []]
        (each [_ [k n b] (pairs [...])]
          (->> `(,(sym (tostring k)) ,n ,b)
               (table.insert t))
          (if (and (or (sym? n) (= "string" (type n)))
                   b (table? b))
            (each [_ v (pairs b)]
              (->> `(tset ,module ,(tostring v) ,v)
                   (table.insert t)))))
        t)])

(fn def- [name value]
  `(local ,name
     (let [value# ,value
           locals# (. ,module :ns/locals)]
       (tset locals# ,(tostring name) value#)
       value#)))

(fn def [name value]
  `(local ,name
     (let [value# ,value]
       (tset ,module ,(tostring name) value#)
       value#)))

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

{: tail-ns
 : import
 : ns : in-ns
 : def : def-
 : defonce : defonce-
 : defn : defn-}
