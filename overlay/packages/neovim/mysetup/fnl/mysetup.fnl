(local fennel (require :deps.fennel))

(table.insert
    (or package.loaders package.searchers)
    fennel.searcher)

(tset fennel :path
      (-> package.path
          (string.gsub "/lua/" "/fnl/")
          (string.gsub ".lua;" ".fnl;")
          (string.gsub ".lua$" ".fnl")))
