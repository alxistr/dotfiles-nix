(ns :mysetup.core.fennel
    (:import :fennel fennel))

(defonce inited (do
                  (table.insert (or package.loaders
                                    package.searchers)
                                fennel.searcher)
                  (->> (-> package.path
                           (string.gsub "/lua/" "/fnl/")
                           (string.gsub ".lua;" ".fnl;")
                           (string.gsub ".lua$" ".fnl"))
                       (tset fennel :path))
                  true))
