(ns :mysetup.core.fennel)

(import :fennel fennel)

(defonce path-patched
  (table.insert (or package.loaders
                    package.searchers)
                fennel.searcher)
  (->> (-> package.path
           (string.gsub "/lua/" "/fnl/")
           (string.gsub ".lua;" ".fnl;")
           (string.gsub ".lua$" ".fnl"))
       (tset fennel :path))
  (let [{: add-macros} (require :fennelns.patch)]
    ; todo
    nil)
  true)
