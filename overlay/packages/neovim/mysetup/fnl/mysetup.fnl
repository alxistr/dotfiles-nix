(let [fennel (require :deps.fennel)]
  (table.insert (or package.loaders
                    package.searchers)
                fennel.searcher)
  (->> (-> package.path
           (string.gsub "/lua/" "/fnl/")
           (string.gsub ".lua;" ".fnl;")
           (string.gsub ".lua$" ".fnl"))
       (tset fennel :path)))

(let [variables (require :mysetup.globals)]
  (each [key value (pairs variables)]
    (tset vim.g key value)))
