(local fennel (require :deps.fennel))

(do
  ; install fnl loader
  (table.insert (or package.loaders
                    package.searchers)
                fennel.searcher)
  (->> (-> package.path
           (string.gsub "/lua/" "/fnl/")
           (string.gsub ".lua;" ".fnl;")
           (string.gsub ".lua$" ".fnl"))
       (tset fennel :path)))

(global s
  {: fennel
   :fnldo #(-> (vim.fn.expand "%")
               (fennel.dofile))
   :text (require :mysetup.text)})
